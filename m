Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E39695D09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjBNIfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBNIfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:35:22 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548FF974D;
        Tue, 14 Feb 2023 00:35:20 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f34so22427185lfv.10;
        Tue, 14 Feb 2023 00:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x65XtyIfR+ZJ05hwpjz7xjX2mVyl1QeYBrniTfHqa60=;
        b=UKaPO3Uur1CbXPKbA2/Vj7sENyfzQYgOw5b3WeCnWN4PmtNi4/OIxsnpuKah/7kPFs
         5HCA2lwzkt+WkUBLeFM1UEM7TTJHdwqd8kbGRho07qoB3m3/TYyo78L+ccQqUO+yko41
         kUELxhjOanKB1A/3XUupy8D8U5v6qCX+waLmHZGBo/YDWOqb9E6QJyzPRhunDJvJrOz+
         KfFsGPkJ2DiKb/qmTCDvh8oi4k7DJqRTY91CyYjztVO/r9V+sjftTjtwKD4faBiWseOl
         JhVcdf45eM3kHALWJziU3ChqN91AhPMfKet14k8tcXPWfhbIfwhaA2O4H9LEGN1LNJdz
         H/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x65XtyIfR+ZJ05hwpjz7xjX2mVyl1QeYBrniTfHqa60=;
        b=Yt0WiZ+MW1pE3ij1bjk7cH4WLOZbhnnkm3Hwvx3rb5JVMszzeZMP/UqemU7PW8d+rf
         ukv/25QKtkgpJHuWOr5ID9du0NrSvTrmjFem8mSNV12i801TzZC0YCQKP9hr/6v0Z2gO
         Vl4VX8CcRuHjMFi4rgm7GeJlOVk2I5c3sUKtUEVi4XsN1ctvYexXxURRyY8NAsCbvB2D
         F7KSWy+3FBVQ6/Dc6iuybC0EPDhrUJceb0RSvGOKAXyz1WSeuguuFdX9N3ccVmqtMeYV
         5v7jXzi2CPLaMJDKcUolgrwyLM8p6jqjXpgeudIdYmHZpSjfppOHXqZaxKGlqgxbhN/l
         R5rA==
X-Gm-Message-State: AO0yUKWPQL0Zb2et2llo81jxSHlOJ9RE1I8f22mbi8ixtUZe7rhLu/6W
        yDmf6jtOudRwdaxb6PYcJyyuDoMa9uM=
X-Google-Smtp-Source: AK7set/tooVt2BimFjOg+wATvIPv1I3VIevFYeSLtk3fjnn7ySQeUyz4nyEsGx7zjQc+8+ifeHsP+w==
X-Received: by 2002:ac2:561c:0:b0:4a4:68b9:6085 with SMTP id v28-20020ac2561c000000b004a468b96085mr496252lfd.16.1676363718209;
        Tue, 14 Feb 2023 00:35:18 -0800 (PST)
Received: from [192.168.1.103] ([31.173.87.80])
        by smtp.gmail.com with ESMTPSA id c7-20020a197607000000b004dafde0e7b7sm1042426lff.279.2023.02.14.00.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:35:17 -0800 (PST)
Subject: Re: [PATCH] ata: pata_octeon_cf: drop kernel-doc notation
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230213212549.29914-1-rdunlap@infradead.org>
 <51fb5b13-3e9c-785f-b96f-6f398389d434@gmail.com>
Message-ID: <c67e4b38-7bec-0901-b13d-6390c1d51cd8@gmail.com>
Date:   Tue, 14 Feb 2023 11:35:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <51fb5b13-3e9c-785f-b96f-6f398389d434@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 11:33 AM, Sergei Shtylyov wrote:
> Hello!
> 
>    Hm, why didn't you CC me?
> 
> On 2/14/23 12:25 AM, Randy Dunlap wrote:
> 
>> Fix a slew of kernel-doc warnings in pata_octeon_cf.c by changing
>> all "/**" comments to "/*" since they are not in kernel-doc format.
>>
>> Fixes: 3c929c6f5aa7 ("libata: New driver for OCTEON SOC Compact Flash interface (v7).")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/all/202302101722.5O56RClE-lkp@intel.com/
>> Cc: David Daney <ddaney@caviumnetworks.com>
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Cc: linux-ide@vger.kernel.org
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

   Oops, replied from a wrong account... :-/
   Damien, please let me know if you need this fixed...

> [...]

MBR, Sergey
