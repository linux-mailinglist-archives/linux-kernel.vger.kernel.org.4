Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B26A6C3B00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCUTvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCUTvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:51:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD156580FD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:50:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id le6so17182390plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679428230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tB+q4A3V2LRdFOInYzmPO6vVhSr/l1xKh0mZyt+GoJw=;
        b=OIrvjeYO9TJJdMh9SYTDztb/xjKJkGzGVIi2Oang+W+e1VIVO4lt8y7QhUH+EfSdDB
         BIR3QSJejiX8v0lInHFb9giWVMUJuKFdq1Ky9EKH2NJh/OV/tVdHKV2bDX36SHGO7vXO
         /O1g1URQCPJeaiRTqgLkWhMwk0FDE6CYKaiz75ZU5GUc41FIuUvVwNiX5Z8jn+GJuCxc
         C3Yhy2ZBVmLB2/hhbgK146tZl9igjeqSTVv8iq+giPMJrZsEYHwjR0i295NqavQv7tIT
         CGRFGUgQo8eFj0nwxN/ndB1fyn2UfBnAk0kpcTpkijzk2Huj1MuZpPCXI0oDSbXBuG3n
         3Yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679428230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tB+q4A3V2LRdFOInYzmPO6vVhSr/l1xKh0mZyt+GoJw=;
        b=VsZArmIcIJsyPED4E00PVF0URpCdVM6S6dhwR8bzj9k85/oWDAPw5JyKfomnCmQNWh
         s4k0uSmTq0UP4XdxyCSVstJW939HMtBV3PlWwUtJsxzCvhUWMGQDKlylF7j/015tfDkW
         2nvjsHEkgYka/v8ciEWRDBqwjitHrnb+pUQYXJhylveNFQ6H44zhjdzO0e3BhKwFOfRC
         d983PlVUiAhdEXYoNGOH9+8DXBRdFzGv/fCx+DuyreutWXi3VejZMnVFs9l13PPer6yT
         pnebkxjMX18DP1PnioK1yqBIei6WZ5jnPqYl/EZa1bh2UMTvq10WAbdPBUUe11ps4AQV
         vOXg==
X-Gm-Message-State: AO0yUKVrDVOtu4GNOztNhA5HJk0VdYTA3BPJ7OuVmfKNCVb1/2d5Qpec
        Zv7nS2Gxd8NVR56NYRc4QzFAEi1c+BxMew==
X-Google-Smtp-Source: AK7set9RuWUF3FpoJpNhGTq1zue4HEhq6NuTQEJdGeIlrLnFjufcCo1chUv6Qa/BrzHACZYUuxILZA==
X-Received: by 2002:a17:90b:4a89:b0:23f:a810:c07b with SMTP id lp9-20020a17090b4a8900b0023fa810c07bmr780987pjb.43.1679428230532;
        Tue, 21 Mar 2023 12:50:30 -0700 (PDT)
Received: from [192.168.1.36] ([117.200.133.231])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090a5a0400b0023acdac248dsm8330978pjd.15.2023.03.21.12.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:50:30 -0700 (PDT)
Message-ID: <50ead5e9-27ab-39f8-2319-ae7695957e87@gmail.com>
Date:   Wed, 22 Mar 2023 01:20:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/7] sign-file: refactor argument parsing logic - 1
To:     David Howells <dhowells@redhat.com>
Cc:     gregkh@linuxfoundation.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
References: <20230320184345.80166-2-sshedi@vmware.com>
 <20230320184345.80166-1-sshedi@vmware.com>
 <2051795.1679382250@warthog.procyon.org.uk>
Content-Language: en-US
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <2051795.1679382250@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On Tue, 21-Mar-2023 12:34, David Howells wrote:
> Shreenidhi Shedi <yesshedi@gmail.com> wrote:
> 
>> - Use getopt_long_only for parsing input args
> 
> To Greg's point, this should probably be the subject line of this patch.  In
> the body you need to explain why/what the point is, which:
> 
>> - Use more easy to remember command line argument names
> 
> might be part of.
> 
> David
> 

Hi Greg & David,

Thanks for your time and patience. I have tried addressing your concerns 
in v6, hoping that I have got it right this time :)

--
Shedi

