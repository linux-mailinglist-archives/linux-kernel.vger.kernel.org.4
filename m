Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCBB6F7D97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjEEHPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjEEHPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:15:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3DD1609B
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:15:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52867360efcso915725a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1683270904; x=1685862904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxqJcIXvhMORECzMcJaMrx244bWaRG+/vAO3MCrAr3s=;
        b=hV+MFpohuUXYauOYRYhbRaK/H+yFCvjn3wrrxLeBkK85InJEW64tFBBpwhz3eV37ep
         qvTZwXRVO6/3vN6YT5/zXMifiXeHKYfj8fr+tY4j8C5j8xu6/J/aBYA0GatF5nagMZsU
         Lqzoqb267NvMCNVuj6ckPDo29yAEMni7lYupfiTwDlMFQoEJHdOBybMDvY2MzglaqJ22
         AQ5VqiQ2OWIIdw63mR6AoU+X+mGpMiLIe98Brcjh9/r1qvZSgyEmWZkZ60fEwnXDyDdg
         2eDU0KkYyytwluF4aOFYPmU16QBQ1BQ2NkamlhILJ0MYAdh9Ii1joj6FbrcHkEQA6k9r
         jzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683270904; x=1685862904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxqJcIXvhMORECzMcJaMrx244bWaRG+/vAO3MCrAr3s=;
        b=QRfLOMea8qHTjlvC+lBaOFdswSQqO5Dx9QZiR6MyFYS13yCvWi/UA7infyevrI3StQ
         yoC2RgFiLMSz4Mi7r/PzQ8DStdDGAD7FZ5PbLqKdKAkS+xnVJ2hc3iG2v8vQvUKf9mI3
         4yUlGQa1v18LN6WTwMBHReGeRc5EQ+WXYJ4wwdJ5GyqufT8CR3RBLXkJVuBFIxLflyFU
         Rxe8AF9qp1O5uguO/Zq4WjQY3gRZZQQISPesiwa0Wurz01GAKw5FAeT87ynZNtjEOUTY
         6em+WV77BXc6hEkW5eDa6tze/382W7dP8Sx99XTZRRhw/F2XQ1Z6+nZtgPhHyVR2AYEZ
         1YWw==
X-Gm-Message-State: AC+VfDw+7dIb2bYqziFFUteNKOOAoMWGCh4tl7ysfAwDZMpw6WhdZI4v
        51bGwFTW2uJ8uFxzPMoz6PKqhw==
X-Google-Smtp-Source: ACHHUZ6DR2XrMAEbJhlwPABhXMOpqR2Gt3GgONFwZj6rLdG0sTrrAoz7ODHnWmwzO1Xko9lmnUD3vw==
X-Received: by 2002:a17:903:18d:b0:1a9:80a0:47dc with SMTP id z13-20020a170903018d00b001a980a047dcmr593627plg.3.1683270903926;
        Fri, 05 May 2023 00:15:03 -0700 (PDT)
Received: from [192.168.11.19] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.gmail.com with ESMTPSA id c7-20020a170903234700b001aaecc0b6ffsm917827plh.160.2023.05.05.00.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 00:15:03 -0700 (PDT)
Message-ID: <7f6236cf-ef48-5d54-7847-fa74cb3eb2b9@landley.net>
Date:   Fri, 5 May 2023 02:30:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] sh: j2: Use ioremap() to translate device tree address
 into kernel memory
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230503125746.331835-1-glaubitz@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <20230503125746.331835-1-glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/23 07:57, John Paul Adrian Glaubitz wrote:
> Addresses the following warning when building j2_defconfig:

Tested-by: Rob Landley <rob@landley.net>

Rob
