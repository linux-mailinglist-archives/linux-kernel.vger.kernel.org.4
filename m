Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A334602339
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJREYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJREYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:24:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FD1EBD;
        Mon, 17 Oct 2022 21:24:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l4so12688400plb.8;
        Mon, 17 Oct 2022 21:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i18Ca9h9wygR53zLge2dretL8mFnfQx69h7ZqTbONjI=;
        b=nihPwZ+TfeVL1yYE34/oNK3CLKVAKQPzjVSc1rC8+/XaIc4igF6VbLJTMbkqVO/Bn0
         sWLIvKJxJpvulIDrNe2cy0diTgIqli8F4bsXgFCZmTsr3Ll5hGfABzDCyJ6rkDS/nSga
         8s+PMnJOWZmUbn6l3gH2CZwVMkxdNnv9zHZcawvDRogBRAnDq/X1HhUftrDaoHdCZbgh
         0/jjwT7LYYSTSHuWqiWBiD5ANfr+FDn0Hqm15Wb+rySHoxOi4AU3YAkktPe5reqjdUl9
         g7URlas1Zn1mfBEBJd07AFDYMIPoH8Lnc1Xx6IOMF/MqHl042itsgvuY1Nky9TQp/JGb
         V5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i18Ca9h9wygR53zLge2dretL8mFnfQx69h7ZqTbONjI=;
        b=DZ+xfUTCkocPTlgExTJerRvPPL69gLHfbVy+AQ/euSCIHrfiqmDT+x6W3lBGCdpRdp
         ovM8/qK/T615d2E2fH6uGaJgf1EiIp/wYBsxzxiDKGGalWPKBHRY29DHeC6tFx/1RPIB
         yzb7XOyR5bE9qcVL6IEhwfQoB3cfsL8UvgAZgGAderuRcUswbRpaLrAtXsPkp2aTGGy5
         fqYOwPEGMRYdX2rmFIHgdNlqI3CcuN8xlxMCh6HqwZUAe6uI0V2b9L79qNLEm/rzT41C
         kUxJEBTzQRR3zmIE63GglODntXRL0RnM6gHfU4/pWb1p5SfuE8phxrAGaq6C/8aHyegQ
         DPIA==
X-Gm-Message-State: ACrzQf2dAFkDfmWM3lBJCsHttMyZfz8QeBTCtG8Sr+U5HJ2vNo+LfdJ9
        yYB2dBM+HPyDme8sAzAuF9s=
X-Google-Smtp-Source: AMsMyM7Cuf3/2MZmZvcomV9tNU1UpFlHnRIBvvWVkwT/zyMsUPlzhZvGdvM+uuoGEWAbPpsj/QgBcg==
X-Received: by 2002:a17:90b:4a4d:b0:20d:4dc7:fa72 with SMTP id lb13-20020a17090b4a4d00b0020d4dc7fa72mr1356234pjb.86.1666067061297;
        Mon, 17 Oct 2022 21:24:21 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902dad200b0017f8caee944sm7528049plx.147.2022.10.17.21.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 21:24:20 -0700 (PDT)
Message-ID: <62951a8b-bc3c-3f6c-48c2-08f5621142e7@gmail.com>
Date:   Tue, 18 Oct 2022 13:24:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 3/3] docs: kerneldoc-preamble: Test xeCJK.sty before
 loading
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
References: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
 <c24c2a87-70b2-5342-bcc9-de467940466e@gmail.com>
Content-Language: en-US
In-Reply-To: <c24c2a87-70b2-5342-bcc9-de467940466e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2022 17:53:57 +0900, Akira Yokosawa wrote:
> On distros whose texlive packaging is fine-grained, texlive-xecjk
> can be installed/removed independently of other texlive packages.
> Conditionally loading xeCJK depending only on the existence of the
> "Noto Sans CJK SC" font might end up in xelatex error of
> "xeCJK.sty not found!".
> 
> Improve the situation by testing existence of xeCJK.sty before
> loading it.
> 
> This is useful on RHEL 9 and its clone distros where texlive-xecjk
> doesn't work at the moment due to a missing dependency [1].
> "make pdfdocs" for non-CJK contents should work after removing
> texlive-xecjk.
> 
> Link: [1] https://bugzilla.redhat.com/show_bug.cgi?id=2086254
FWIW, this ticket was closed recently. It took five months. Whew...

Now EPEL 9 carries texlive-ctex and its dependencies.
It is now possible to build pdfdocs with CJK contents within the
confinement of RHEL 9 and its clones' packages as long as you are
OK with enabling EPEL 9.

        Thanks, Akira

> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
[...]
