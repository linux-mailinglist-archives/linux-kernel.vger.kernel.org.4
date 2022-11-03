Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A86189D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKCUrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKCUrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:47:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8C820BDC;
        Thu,  3 Nov 2022 13:47:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so1554590pjs.4;
        Thu, 03 Nov 2022 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvWv7py5M+cpuNli8vw2OLBU1voxtMB9/LTt5ZmUfQU=;
        b=JvSaRJzb7KxQBZ9I5GR60ZkQEIVeMaZ5YOYp6rdau38npwjLIJJj+uq8pTHPxyQ1zI
         3NYz9vX7/YDfrHF2AJjI8TGJH4JEU2qFNMBM/Ua4Yei1F1L30tNQiE+Os9yGG1aCwUkW
         c7+dIDRsbYyU+kLZtdMuK+kYlt60LGL1auM3ppfbMIoDm48ug8Pa3MS4GueeHAUj5Sul
         Jo16wsZjueXh87EgWSuA2I/vuvxDLufPs+h+G6ZSZt/D2hTe2RAlFZ/X0beeZa7AD17q
         ceNdX9xIyEP66zeAEc3kZPtisLxEtsMkjVpn9GxGhu+2eSObu/E0P6I1pgjq8aJnKQFq
         Tr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvWv7py5M+cpuNli8vw2OLBU1voxtMB9/LTt5ZmUfQU=;
        b=Xa2JK+tYidtLf8fCVtog6d/l4AO2IwQI56YIoa4ICt+gr+l3RfBvxUeQ48auBJwBCE
         ATPjAABrt16uXf9eEWjDa8mlrYnP5Hkpscce1xSrV5I5NPm9jA/pmVkg3w189HwP2tja
         c4qg6TTpUTDCgGykEUNCPV+qOjYSAK5yOL75kuhF/ie6BFBoD81JjbRMtY9Ef4T2jKU3
         DIX7IHYYEl75AzmC93BCLNjT/CGijfn/OiLKzt7ActtrHjL6n8EHSw+qqMrUiEvDoTCf
         FePtCdSUbuAFdCIHLY+u4XroKNV+hj+Xk8nQaV7H1GEQ12qU6KWKRUMXHmhLA8ffWNGk
         yVkA==
X-Gm-Message-State: ACrzQf0DyJTl/1jb32Vv+SqW2qq0+4MiNRmYLL3zMd5pR4PK+ofrylQE
        4/VZg9w2pUiRObmnSyN+BB4=
X-Google-Smtp-Source: AMsMyM50LQ7X2DdQ87M3IejBmk4+j4HCY2M2XeDa0MHv1bRjGnWJQuCM9bnPNrGymDvHzAy2Q/0wtA==
X-Received: by 2002:a17:90a:4283:b0:214:1329:dede with SMTP id p3-20020a17090a428300b002141329dedemr15972157pjg.149.1667508422363;
        Thu, 03 Nov 2022 13:47:02 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id c189-20020a624ec6000000b00561beff1e09sm1155143pfb.164.2022.11.03.13.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:47:01 -0700 (PDT)
Date:   Thu, 3 Nov 2022 13:46:58 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 12/30] input: Use kstrtobool() instead of strtobool()
Message-ID: <Y2Qowvjn+7jT767t@google.com>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <4311e9cb62687449f4175e2b062abcd77aada059.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4311e9cb62687449f4175e2b062abcd77aada059.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:14:00PM +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the series. Or let me know if
you want me to pick just this one through my tree.

Thanks.

-- 
Dmitry
