Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38C0718664
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjEaPbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjEaPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:31:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B4310E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:31:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b18474cbb6so2866515ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685547090; x=1688139090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gqlM3HicN8bZI8y/HXeLeK/HBncomDasUqIVXEA5Vzw=;
        b=k5e9OshTFnP9OEHnNOE5n9RB8t1s+zscxlxRJpU/MtmoolYIDh1NROZRM71KSbCm/H
         5YlAGxk40/pkYJSGp3dE5Y9vNnqKze/uVxokBgV7mDh3QeAuLvlw/LeKddNzxvB4F/gK
         jdb8S8vv7TEfP1pPQcnVmEv7ZiSmmLeOWpulqA8uwz/lB6HvnDSBAg67D6x5c9qWu8qd
         wWCnJmrC5FKB1J0M73GPF980rHJf1YAwyFcfdvaLoyy0K6Ou/N2yt3hR0pXIjIjcDdGb
         jsBGyFHTWU3TMXB8NrJBo+aK894bs4YwhyZ2D1UwjZCyL7bVW++ZObfOCOXjI9Sc3eyx
         Beyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685547090; x=1688139090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqlM3HicN8bZI8y/HXeLeK/HBncomDasUqIVXEA5Vzw=;
        b=SDfHFApA513sW8FFH0bOp1czR+Z0SPEngetPTj8LUP6ueEZxqu/VZyc1QcVTUog7vV
         m6uPPsSJ7zFLSHTo/iqkkkuY1uwbIOs4FIXuwzjH/65NvYpBblBxqab0+FPqobrdG0Ua
         SBxHfyA7gNb3GLMjl8g5VbEy/l5iwfpBSbNaOKdOaSVcEnJH/ZqoBjJ03ZtP3KfTcX3A
         B0lGCFuNNN12U8+zBKlgCI/z/0UXJSMkqwdkie4bOEjqDHFqre7cYT4xfXk3ABf51urA
         7gwtYqXz952fJQLAy7AKjo+28MINM6poYqRzdiS48N3ootkIyTEVZslCVoyqvmt8n3Vd
         NL4g==
X-Gm-Message-State: AC+VfDyPSeN3kHGVQgp7u0dS9a//3KBqOQszIHBU4GghijvWbu3DNBsT
        IiLU9UZQJJxqZy1qs2QRH7s=
X-Google-Smtp-Source: ACHHUZ5kpn+rSpBaqf2DdtPSDT+Ob8m/0QzW03XU/Cr5OxnxFdbau+d4qf+4GBDimRUK26eC60iF1g==
X-Received: by 2002:a17:902:a508:b0:1ae:8a22:d0dd with SMTP id s8-20020a170902a50800b001ae8a22d0ddmr3831219plq.58.1685547089676;
        Wed, 31 May 2023 08:31:29 -0700 (PDT)
Received: from [192.168.0.105] ([49.207.240.61])
        by smtp.gmail.com with ESMTPSA id jk15-20020a170903330f00b001b024ee5f6esm1543653plb.81.2023.05.31.08.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 08:31:29 -0700 (PDT)
Message-ID: <cefc1a42-725a-8afa-c222-f4df085ba6a2@gmail.com>
Date:   Wed, 31 May 2023 21:01:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 0/7] refactor file signing program
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
References: <20230321193341.87997-1-sshedi@vmware.com>
 <0ae37bcc-4398-644b-a295-1245d73e5450@gmail.com>
 <2023053135-bubbling-commodore-3a7b@gregkh>
Content-Language: en-US
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <2023053135-bubbling-commodore-3a7b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31-May-2023 20:08, Greg KH wrote:
> On Tue, Apr 25, 2023 at 04:14:49PM +0530, Shreenidhi Shedi wrote:
>> On Wed, 22-Mar-2023 01:03, Shreenidhi Shedi wrote:
>> Can you please review the latest patch series? I think I have addressed your
>> concerns. Thanks.
> 
> The big question is, "who is going to use these new features"?  This
> tool is only used by the in-kernel build scripts, and if they do not
> take advantage of these new options you have added, why are they needed?
> 
> thanks,
> 
> greg k-h

Hi Greg,

Thanks for the response.

We use it in VMware Photon OS. Following is the link for the same.
https://github.com/vmware/photon/blob/master/SPECS/linux/spec_install_post.inc#L4

If this change goes in, it will give a slight push to our build 
performance. Can you please take these changes?

-- 
Shedi

