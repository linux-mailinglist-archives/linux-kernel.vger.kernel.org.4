Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DECF6CB9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjC1Isy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjC1Isq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:48:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C34C1FD0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:48:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id ix20so10993003plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679993325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2EU0PyNq3O8MZWQ5fwe8D0KcNrdW4uSY2h1xR6nDBTY=;
        b=O1fseohERVPEn6YJLD9y3VUPQsGzrgbrkJIfTSl9xCaOo75kgq43d8pjF3GzYx1/6U
         yrsneVKGZgNYNlkK8W3ssCUSLyiL06l/cv/406aMcxLZcUb/wZW1p4UrpEVGjQN68eIh
         gazN69EOPahWQzBm/EqOqHY+EQqq5hotUOMbDXwQaCoz/cV1/J0mCA0N2XH//2bf75Ki
         aKmelLIj0QBq9QgbMH29g5T0vXYAeDbp302OKg3AoanOIZNnCSldqtBtsB8SU3mljY+k
         I8na3S2TETg/RGb+lMridKvA+cxRuS/VApvOMVuEHhS1DrWG3Z/4HaRU5p6wl/p8zuQ1
         XOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679993325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EU0PyNq3O8MZWQ5fwe8D0KcNrdW4uSY2h1xR6nDBTY=;
        b=WwcPpbgXvEchACWNE3bFNnDgkKP2NjZvEIkk00cpq6PXPCAAEAf5xVTgEvqRsQELEb
         43H+cQA8VTI6LGfxsV/C2G/Txefhzd5ZIBOLzXBk2LCzwU0k2g9kDz1wtHL7rtw2efBK
         AodUTMv+xHKT76RJAlXWJR/EwBOjEfo/giddp2DTp0++VuQ5RJlXt5WZEWi3FmnEtLWI
         XsVIOXjSPZZGktOhbsIB1MVdrqpX3jaZOaDlVxNowLlLOJd7YRLyqin+Hf+vY1NdJd0p
         n9j8P93D9On3tsZ1SH7zElndP1moEBIYMBWDyR9kyDI/QpKRaSMn9JYjparJx79pOdY/
         Ik9Q==
X-Gm-Message-State: AAQBX9fA/11aZMroBdpLXZB4EynUaAD5S8Ixqg8pdjrYK/x4kFKar0Gj
        WmDrpRKcCbPqEDknjPK+uhM=
X-Google-Smtp-Source: AKy350bDFGo2uIQNJg8uJdqaz7Tcc+lLE2OM3k8eagzfuLp08YrhaAwCSltX2PHBSqX3FPQ+08YONA==
X-Received: by 2002:a17:90b:4f89:b0:23c:fb54:95d5 with SMTP id qe9-20020a17090b4f8900b0023cfb5495d5mr16211336pjb.41.1679993325434;
        Tue, 28 Mar 2023 01:48:45 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-54.three.co.id. [116.206.28.54])
        by smtp.gmail.com with ESMTPSA id n8-20020a6563c8000000b0050f9b7e64fasm13366907pgv.77.2023.03.28.01.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:48:45 -0700 (PDT)
Message-ID: <fb1352ba-69a8-c1cc-7d72-43836f412e3d@gmail.com>
Date:   Tue, 28 Mar 2023 15:48:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/4] staging: rtl8192u: add '*/' on separate line in
 block comments
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jerry Chuang <jerry-chuang@realtek.com>
References: <cover.1679945728.git.kamrankhadijadj@gmail.com>
 <140e0928531e61dc7396271a5b16a6be17514c76.1679945728.git.kamrankhadijadj@gmail.com>
 <ZCJepCj9JcOQqp0Z@debian.me> <ZCJ2_PuvCUBvlwaL@kroah.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ZCJ2_PuvCUBvlwaL@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 12:11, Greg KH wrote:
>> While at above can you please turn these comments above into kernel-doc
>> comments (see Documentation/doc-guide/kernel-doc.rst for how to write
>> one)? This requires a placeholder doc where you can write e.g. overview
>> of the driver and how it is used. The doc should be in
>> Documentation/driver-api/staging/ (since this is staging driver).
> 
> No, these are static functions, or just normal internal-to-the-driver
> functions, they do not need kerneldoc or any Documentation/* entries,
> sorry.
> 

Ah! I don't see the context behind the comments, thanks anyway!

-- 
An old man doll... just what I always wanted! - Clara

