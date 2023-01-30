Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED01F680539
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjA3EtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjA3Esj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:48:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB22C2449A;
        Sun, 29 Jan 2023 20:48:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 88so10007918pjo.3;
        Sun, 29 Jan 2023 20:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EfmboWJ2yx6Z+ujI3lKeLSMZ3xaikxZUL6sdB6MayYg=;
        b=OoGETTFTzQnLUfzjgaRlJLMCF2WFBeQWJnEp9A8KerMSfFs3ytI9Je0Xe2rygBunZJ
         9sTf33AV2OFPRv9rpNDChDgvs1fVKfqmxmW/J1AJmludDdqELbkHQ2I8rzeiuHsrxLZt
         amrKxUHTBFzeECh9ozewxpFaMzxHOAmNKYSppvb+GzaaKuzIFRSTkXyw/mevEBYJYQEA
         uumYFAnetFKC6AGBajtEdAm/5afORL5sHnhdmA3dRmIOawYDc1d1jcphuefKoYtdKYU1
         BtQKv3p5EVuK3OPYnVkEUKIuZ1Z3uVp3YQ27Pz7QCCV66aPXwy1SJx+xlE+KxPwWQyja
         pKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfmboWJ2yx6Z+ujI3lKeLSMZ3xaikxZUL6sdB6MayYg=;
        b=O5M0vheOwUfC9rQBkHlpFrmg+oG2P81QlyUwVo/oJKv2bEjyf7F7056421eAXDUgA+
         4nquQdlBLJqi1ui2nnrhjS5WcYEUJlTQLwr5LtAaBE3NcXIuF6tQk6e9mXCy4Z5zZHhS
         SxaNN7LpK9mqvD63rvcKhHbTPAMcnxt/xD2ZGpxYxeuqkrcS8f+Gqyzr6kvKMImC83W4
         t/0+Vppx2lAnnB6/gg/eI59efqIaivrf/YJ8BvWYvj2TPAV1Yeo00UM2TX/KxGSKrPsv
         IB8MAT+XPOl5vcw0h0pF9hnPWAJ84gJRB4jZXja9G1lXKKaYd3lHPSNkWDQhQEmgbLNX
         mBsw==
X-Gm-Message-State: AO0yUKXj2fkeVlmKQJro0Zcq+7Bi4lAXevXJ/aCA+FHlQXb618zJF1az
        lQec3/NXolSy2q7LDbnN+vMqoI9V7RM=
X-Google-Smtp-Source: AK7set91zPgTYKq+68cx8Kvk/FOKzEz2CZQiMGTvuBTcsEdawN+Mznt5znJtbErQ0ke0lCf+MTnbcw==
X-Received: by 2002:a17:903:234c:b0:196:11ae:95f6 with SMTP id c12-20020a170903234c00b0019611ae95f6mr28331978plh.21.1675054108280;
        Sun, 29 Jan 2023 20:48:28 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001968b529c98sm337067plg.128.2023.01.29.20.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:48:27 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:48:24 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     andriy.shevchenko@linux.intel.com, jonathan.cameron@huawei.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: =?iso-8859-1?Q?st-keysc?=
 =?iso-8859-1?Q?an_-_Use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap=5Fresourc?=
 =?iso-8859-1?B?ZSgp?=
Message-ID: <Y9dMGFABM3s9e2U1@google.com>
References: <202301281611305841413@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301281611305841413@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 04:11:30PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thank you.

-- 
Dmitry
