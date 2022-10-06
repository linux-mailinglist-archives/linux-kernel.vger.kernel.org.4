Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198CA5F6463
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiJFKj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiJFKjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:39:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B891E97D45
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:39:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qw20so2959685ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:to:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qy1SQssJgpmu6E/3UJtpV1dla+gXgwxJp38uBeeurqk=;
        b=llzS4465S8Cem8lOqSeBQkABDbMKrFD7zBtRuJVELtLKveS34ajuEU+IYb6hnvGl0o
         DzbYQdsfex41ei1f4ayMOiuALXLbqRhdQHRohUfB8QBumL64b3bfHczuzwIms2UUGlMr
         4cDwLSUgOeXdez2bKhkyff9pM9T3WIhcwUZLFf/xo+l0YtrY51WqSLMznfXnL4wmx1JD
         WrbZA6RGw5azBKgkGblOlnHc9GXxErpFMCrfPdfX3xFawpqnRnRvIYeI790cvqpBRt38
         Mwq9idaofzDjng0TN/MGF5lxrfaUF1suQHl6s0/EJ1wHw4ThUa2AYAc1Tb4OfXWhT3kk
         KbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qy1SQssJgpmu6E/3UJtpV1dla+gXgwxJp38uBeeurqk=;
        b=gIHTDpOezMAqmMeDqwKf86iSl3d6DTmi++vhNIaIeeIEaSAMfQXmYIEcL0LOLWw4vL
         h2p440/OCNeM7Ps8w13rCDS5x+nnZ+eRX03O7U0kCVEDDeEV5vKvTtoESB30guVyyJ/U
         /UllKvnvmkfDCv2sXvkDGUSGbiArvhx9bklVnd8fGI8PUlziA+P5IK6YiNmfoCBEMcoc
         NvmfRivzPAk982z+Gpvg5s0tnVkgwWPzSk4NrIY+LH6KIouaOwnWCkZQ5H5RiLgJlvhV
         HeFRlpRpwSwXy7KHHcMUSUUWNqxPzn8tnr1Pj4+qgP1/1ZVHovbSOZrRZ3GpKrkAyel6
         0+kQ==
X-Gm-Message-State: ACrzQf0a7H06OhTlmhTNUWPg+TgdOE6c5z9lAKyMo7oCQW/9X2NTyrME
        x1RisUETLr7a1h/e7meTEPaCXVSwORCUAQ==
X-Google-Smtp-Source: AMsMyM5U4gE2PlJNKLval+O+B6AJriV+SC7F1EoT81ovBnjt0TIXsf5/ssSowfZWO8bMAcd3cYpF0A==
X-Received: by 2002:a17:907:c05:b0:73d:6e0a:8d22 with SMTP id ga5-20020a1709070c0500b0073d6e0a8d22mr3444804ejc.646.1665052763265;
        Thu, 06 Oct 2022 03:39:23 -0700 (PDT)
Received: from ?IPV6:2001:9e8:27fc:4b00:6362:cb9b:f9b:6c46? ([2001:9e8:27fc:4b00:6362:cb9b:f9b:6c46])
        by smtp.gmail.com with ESMTPSA id o25-20020a170906769900b007829fb46a0esm10225598ejm.142.2022.10.06.03.39.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 03:39:22 -0700 (PDT)
From:   Marc Miltenberger <marcmiltenberger@gmail.com>
X-Google-Original-From: Marc Miltenberger <MarcMiltenberger@gmail.com>
Message-ID: <4c45d359-3e58-05ec-0a40-1ebcf2283af2@gmail.com>
Date:   Thu, 6 Oct 2022 12:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To:     linux-kernel@vger.kernel.org
References: <1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.unizg.hr>
Subject: Re: BUG: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3
 through 6.0.0-rc7
Content-Language: de-AT-frami
In-Reply-To: <1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I have probably the same problem on Ubuntu kinetic kudu using 
6.0.0-060000rc7daily20221002-generic obtained from 
https://kernel.ubuntu.com/~kernel-ppa/mainline/daily/2022-10-02/amd64/

Firefox tabs crash randomly and chromium does not start with the message
/bin/bash: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of 
Verdef record
/bin/bash: error while loading shared libraries: 
/lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verneed record

Chrome (without snap) works fine though.

On my machine, these issues also arose after installing 6.0.0; the 
previous version I used (5.19.5) worked fine. In fact, I've reverted to 
the older version without changing anything else and both firefox and 
chromium are happily working again.

Best regards,
Marc
