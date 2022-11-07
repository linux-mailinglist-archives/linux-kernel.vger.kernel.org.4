Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C3A61F7CC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiKGPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiKGPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:38:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F271F612;
        Mon,  7 Nov 2022 07:38:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h9so16863700wrt.0;
        Mon, 07 Nov 2022 07:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPAYTOGqtJ5XNV/1AT7caGCJRWNvYtUi2mlJFlDAdFo=;
        b=abAkHaHp92Z2vtzOj1SozYZLRTomRw3rmtSms/q6U5bxMks3IC1kG7T1Jj4coIvsix
         tRZ9kGDrhxY2WOBrqZ+srAh5EIXZeZZJu8Nw9C0e+XWMxLvKW+GszXbLWi4Zuu1oDmsY
         C3w27S4X2EkcCE9alBkubM8pg6EYA0ATRKTF2b6HAgkRSRRp8U0fq2y75zHN2JoBgaOP
         UR5BramKRFnMm+wjf/Wx0Ii3mOE6drzHT/JySGDZA2yeSBtjdejVQReg9OBVH6nBzhs2
         PPL6fT0xAnExUe9uKeBMQ9K0QV8nNEfAY4MTG22q1++GvoL6Dd6asO5aL+b5v2S9S/Uu
         HEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPAYTOGqtJ5XNV/1AT7caGCJRWNvYtUi2mlJFlDAdFo=;
        b=4eDdvZ9lPN5eThl/0guDxWWjG45v3oYmIBqBKbSBTqbNQ7P75hfmVK4jOVdhOGcTDl
         v05ExThEoqWZkgPaMy6hcuu8PRmp2/78pb58TOPpr+pGvwTKEBcQ+/nXP2KpbC6qtjW1
         EkIkgIZfTQin8m4PbSfecp95wLLuzi3yRw1DrgmKt9yRYvlQfc0b/fUDEsaZNRwjj+lz
         vPP5m823DNGq4bnwN9TeZVwkhW1ZNE0c8zJ6fOg9W2HckohcQo0y539CHmBbRPwgJ8Ja
         uXAyBX/Lpa5BhsTVZyYPx6OIO0XlmXDDoRuYqLsCvRWdc4JmtauDGAD9ihwHCrrCYrpn
         dM/w==
X-Gm-Message-State: ACrzQf0cmtg6W59wSG363ciwzkNJqqfqt7WKpVT3rIXwXT+k+Mvs5zJx
        piOICZEcNOOK5qJuLic9EnY=
X-Google-Smtp-Source: AMsMyM6ogAqWyRekdBf34FVtsdxyzLUCwPGo0tD7wXyPyPl0rvifJ3bdaOFSULsXiP7FU2+hhTrvXg==
X-Received: by 2002:a05:6000:18d:b0:236:8f9d:6d41 with SMTP id p13-20020a056000018d00b002368f9d6d41mr33498809wrx.658.1667835518709;
        Mon, 07 Nov 2022 07:38:38 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b003c6cd82596esm12778680wmq.43.2022.11.07.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:38:38 -0800 (PST)
Date:   Mon, 7 Nov 2022 18:38:35 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Deepak R Varma <drv@mailo.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: meter: use min() for comparison and
 assignment
Message-ID: <Y2kme/FDg/4K2VW5@kadam>
References: <Y2iFGA3A1w+XMlYU@qemulion>
 <Y2kDTxE38epBN368@kadam>
 <41a43f3865f3c86c6c2d1fbf3d82c42b685c7041.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a43f3865f3c86c6c2d1fbf3d82c42b685c7041.camel@perches.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 07:22:24AM -0800, Joe Perches wrote:
> > In terms of run time, this patch is fine but in terms of reading the
> > code using min() makes it less readable.
> 
> It's not a runtime question, either should compile to the same object
> code.  It's definitely a readabiity and standardization issue.
> 
> In this case, IMO it'd be better to use the much more common
> 
> 	if (ret < 0)
> 		return ret;
> 
> 	return 0;

I also prefer this format.

But at the same time, I can't advise Deepak to go around changing
existing code where the author like ternaries.

regards,
dan carpenter
