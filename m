Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB86F617619
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiKCFW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKCFWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:22:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E118E31
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:22:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k8so1073836wrh.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 22:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHeYRtbQ3BOR9DbNBl//b/ECiZLyzDKiq1z7LfU80Ro=;
        b=cLRHFFC/4i0kC25woN7rBisVFZbJAi5O+WO3FpKztDcZ6Sih+MKjwVgaMCk7b1ZlmK
         6AwoRT0fsSAqWkmu1bypc3oogAZ3Fcc0WkUSA0hslBJ34GxfhcIVScg64Qa5m0aw8YqR
         I09X2XBzK+uMJCx9zJuN1uy+FtlIyQebL3/UDviODhjjTpR2vOqFnXWOghkYllr17/QL
         x537E4VG3qPA0aR6uwh20FQIsTewE5tgZSoVqKIwfzQwvtSUkKB4pcfFPs36m6vSr20v
         jtXxlKqxd269Wc1hV+2zqd4zj8DrttsBMAi5xoXwGbgubL7uaXrQ402EpBYPHwDQPwRF
         ReTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHeYRtbQ3BOR9DbNBl//b/ECiZLyzDKiq1z7LfU80Ro=;
        b=HamJfUOl73WlyZvffzE5mSuw9a7n480zLUG2/lc9wFHg/AW5DLLfIAEKJRJrJd2CtD
         V7GSG6Y4oaFZ40UGTLyYswoLsRfji91VOEx2XDa/GWKGw0uDIP5fs4G8ueJLE+6flvS7
         w5oUDKfBipsdAkpxo4XWR4XrXpwLl/p6voPO+TnVPu+rlIY6fi1M9f+F5c2Ob0gSo7o7
         NlNolVBxTqNa8vGFDrnFyNQCwJ5iXRjGOSer77sbH0NyG6JS9w11Dp8HVK0wwoo0LYPD
         DyVzOzmwDWqbUwQh5qVZLNbng+x9F0WgU9/5UPjrJP9jzPdQ26v2seklqqm82rz6qGhX
         2EJA==
X-Gm-Message-State: ACrzQf3gA4ChacYcN4KPWpp/TnV661e4lO3jGSuaDCCREhoQRJud14Bp
        brqRnusW40TPEW+ArCiiZTo=
X-Google-Smtp-Source: AMsMyM7pvkJpMNweAPAMF6FegnUvSD//sJCqTd+gnDmriuq/ro/yXz1HEH0nR09Za+uaQvmBFQOsdQ==
X-Received: by 2002:a5d:4410:0:b0:236:a8f9:268f with SMTP id z16-20020a5d4410000000b00236a8f9268fmr17515507wrq.405.1667452937156;
        Wed, 02 Nov 2022 22:22:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n124-20020a1ca482000000b003b4a68645e9sm4019487wme.34.2022.11.02.22.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 22:22:16 -0700 (PDT)
Date:   Thu, 3 Nov 2022 08:22:14 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Use flexible-array for one length
 array member
Message-ID: <Y2NQBgUdNPB7g0Tf@kadam>
References: <Y1vRivFfRD6VoBt/@ubunlion>
 <642519a2-664d-d837-983a-1d5bbc72a25e@gmail.com>
 <Y1vjKtM9druO2bSN@ubunlion>
 <Y1vqd/ij5WqcL3Qe@kadam>
 <Y2LCykj5Ntx7yHxu@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2LCykj5Ntx7yHxu@qemulion>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:49:38AM +0530, Deepak R Varma wrote:
> I am wondering if ijk_matrix_regs_set (or IQKMatrixRegSetting) is a one element
> array, why is it declared as a two dimensional array? Can this be a simple one
> dimensional array instead? Is this the cleanup you are referring to when you say
> "code is messy and should be cleaned up"?

Yes.  You have interpreted that correctly.

regards,
dan carpenter

