Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD2862CD99
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiKPWZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiKPWYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:24:47 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5E0205E7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:24:45 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p21so17757928plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0Wl4WXlZ9TtxCS/7cbCnqRMePuRd+lB/ZGpLWihPag=;
        b=Z1e+Sc3OetTCAQVdLTOaCpJQhUAM41Z5P5Zm1uYJoWTHvOeggqH4IDrkjIc7NGsNZz
         q8RzSMAQ6wffrTcixCdTMO8NP/R+3GqN77eQRMHUdLkjfb/Wqphq4NPG70Brt+E7SzFR
         8XnD+jPys9D8fH40n/994uKnYFzZ1sntvg/ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0Wl4WXlZ9TtxCS/7cbCnqRMePuRd+lB/ZGpLWihPag=;
        b=FB1Jclyjwg7OYNk8tdhkDlDdC8I1klyEN2YnnlFZWT4A+AvmFJN88Md2zv00VWVKZq
         xHK8L+93rp+7EgrmegBHdRL/Q1HepiX1m0BsSPfse17LWEDZAdfgui6QahUBI7d94zL+
         CREHBg7BM5Zdi6nZ0KDlGyUnZs7O40TgeYdIv9DppHOCfVyi68id9wufuLfMaLE6z0Lw
         VRdrrhvEfsOs9KA1gBM2v35EkE752RAzqWgn2L/asFE0JfaxmvzzlGpuFDshUunIJdtJ
         eelPwhIiXOjkDqTCcvotg6u5JtNi0v3Kws7za6xMBun5NdqljjpSJVQWoI/70/qnbTRN
         GQRw==
X-Gm-Message-State: ANoB5pl+/l/nPUbzGnCe3qXaZ1xcu8fiVhfFjBWZeDpj9y8LvRact8ju
        8CDYYYqc7PJfDEXqZk9jP74gVA==
X-Google-Smtp-Source: AA0mqf4rz5uYxs0pdlSPjexuCrjBLrAOCIIqlFBQmnF0VeQWmRXzPz48Qx95Oo5rNx5HXl9GQBIZjg==
X-Received: by 2002:a17:903:2642:b0:178:b4b7:d74d with SMTP id je2-20020a170903264200b00178b4b7d74dmr10795273plb.83.1668637485474;
        Wed, 16 Nov 2022 14:24:45 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b0017f7628cbddsm12774143plh.30.2022.11.16.14.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:24:44 -0800 (PST)
Date:   Wed, 16 Nov 2022 14:24:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: bfa: Replace one-element array with
 flexible-array member
Message-ID: <202211161424.A47F4BAD1@keescook>
References: <Y3P1rEEBq7HzJygq@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3P1rEEBq7HzJygq@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:25:16PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct fdmi_attr_s.
> 
> Important to mention is that doing a build before/after this patch results
> in no binary output differences.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
> on memcpy() and help us make progress towards globally enabling
> -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/209
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
