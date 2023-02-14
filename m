Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28A3695AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBNH3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBNH3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:29:35 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E648E;
        Mon, 13 Feb 2023 23:29:33 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z14-20020a17090abd8e00b00233bb9d6bdcso9445115pjr.4;
        Mon, 13 Feb 2023 23:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enCF4Ov/OlkQdmaMaFzB48EzRaEzlSuP3i76xugtVG0=;
        b=YI9+/TJ5ZqYgsshCJGlCFNQctAJFwyuPmJZFZd10YtUMpt+DUyc58ryiTWricALIfM
         zDlRBvAQMGm/f9MKfJO/sNSdPi7iZoPpN7PlEC2GYz4XzqBI5RKcrP58LIWYhBbsooNS
         1ff7nRN9NuJ0KDTxaHwTkH0tijZYngSwcZWTJbix1oa320ZbOWXHhnJOQOqEOGaIOLjE
         DRqywPukX5GHxY43Pv3nbstYHKpHXaoHxsnYZqX8JBkEtzbyZ8Tsp24VE0kxOlRR1k69
         XcZfQDbCNAXrxIzMToRAx+GMin0y5Q48xKo5XlIvgZiOEmlPS94dXLuQSc6LKdhAQw/z
         Nb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enCF4Ov/OlkQdmaMaFzB48EzRaEzlSuP3i76xugtVG0=;
        b=ZNjCdaVjel5CLg6sLjejIJgXd+XsnAIvrle0PfmD7OBpmxj57noxKOv27m6JZ7ui+P
         y/bDsqGUV7i/LHczvXU40XxoKf35P4TezmnTMlIdH5geYgDFROcMMZ+u9spG1CAFMHjl
         KYwx7fNysF8/iBLVTaka973HFG9SHtGDkok+0xppY92z3ASkWr4R90pYrnwFe6fOa+QA
         yELRRtfmbR7NzrUnczh5hTuG7oOtnmQikl8avF5NM+eM0TFgJsP5JJZPR5P0QT0hzqtj
         1E75dWuXnKbyFkb4PslfYR+Pha+E3cup7hsUVldWkBkRhnnMdd/YH6s3twRezDOeYygx
         D8Kw==
X-Gm-Message-State: AO0yUKWlzCH2ryNm97x0nynuPzH8bubFciVD8V1WuCCNHC738IgorO92
        cCnreCYj6F3q3D4ACOAR/OMFG7ylY1A=
X-Google-Smtp-Source: AK7set/Sbhz9vuvzyzM7KAajqXP+UBiOQ0X71zrknnXXe5Wn4IIzoUJtNBzBh2dGUjtYp/2tC5n09w==
X-Received: by 2002:a05:6a20:a110:b0:bc:c663:41bd with SMTP id q16-20020a056a20a11000b000bcc66341bdmr1636765pzk.4.1676359773345;
        Mon, 13 Feb 2023 23:29:33 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-66.three.co.id. [180.214.232.66])
        by smtp.gmail.com with ESMTPSA id k3-20020aa792c3000000b0058bc37f3d1csm9045542pfa.44.2023.02.13.23.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:29:33 -0800 (PST)
Message-ID: <02f796c7-c1d5-2f2b-3385-e72298f5f470@gmail.com>
Date:   Tue, 14 Feb 2023 14:29:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: nvme boot problems after merge of mm-stable tree into linux-next
To:     Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-mm@kvack.org
References: <ed33b9ff-e6f2-dae8-ede6-59dc3c649ece@roeck-us.net>
 <20230213094754.397f86af6b2dea4aafd92344@linux-foundation.org>
 <a276d6ae-677d-e4cf-13d7-934c0a7639d2@gmail.com>
 <58fb32f8-ce1e-913b-3b85-c41b0630d4c6@roeck-us.net>
 <20230214172040.60657882@canb.auug.org.au>
 <07c870d3-5d98-ca51-5de8-034abc631673@roeck-us.net>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <07c870d3-5d98-ca51-5de8-034abc631673@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 13:49, Guenter Roeck wrote:
> In next-20230210, the crash happened after the merge of mm-stable.
> In next-20230213, the crash happens after the merge of mm-everything.
> That means both the merge of mm-stable and mm-nonmm-stable are now fine.
> So I would suspect that something in the merge of mm-everything
> interacts with the rest of -next.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

