Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF816F8608
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjEEPmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjEEPmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:42:49 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C30C14939
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:42:48 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-76656f3568cso10737639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683301367; x=1685893367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJ1JCWzleNVQG9TsUp5HbBlt/oMKIY13y1/3J7Q2wgM=;
        b=AubTYQfzEWmAwgX631PZCxEdsgMDMSqbI8++bXQExHLdxtlcWzCCF3ar9Y1PegwP3N
         lqUiRyO5ZSSuv+A9G9K+A7+Pwh5CeiHU7/bb+ffyegbGLC6bDuAAONBkBN7+R8YENz0u
         cogo3fnPbwVOVbZpGVoS2bVoCM5Sk55T1GtOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683301367; x=1685893367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ1JCWzleNVQG9TsUp5HbBlt/oMKIY13y1/3J7Q2wgM=;
        b=NAhx1H/oz/ZFdwr96V/CFXpFT1huPBf/E8ZgdCIurYYCYw0dOKPaMcgcXrsn01Jfh0
         enL4WWwHcljuB9oZSZcGCYDCG6sZSdQJ5nYA8W0D7RY4pvdFQNnaYr6lkMPIqfmO4bOH
         jm1jZaxxlCQp7FKu5RgrE4tUXzn2ANM/ds/K9ipkW9KWNdV6fVLH8iWbf6E7BVZe2I8R
         eTlu+8AYCPj1aMgnNiyEe+zew1YkASMAN/0Awd1VW1qFfgxz91aKDFFAql9S4dPvlo8g
         J3WNoe3rSsasZAC27+lfg4kR9Es7NYA/V+9wQgaJC1EpLZGlKH47d/XxL/p4Z/EEZX09
         a8+w==
X-Gm-Message-State: AC+VfDxSFgK59Ge+nKL6bGS7vTNKKsHsqa9ZEPqCjEQ4E/3aeT07EugO
        guWCvbQVhRX7mVr0DxRU/EzKIg==
X-Google-Smtp-Source: ACHHUZ51yUvle1MGzTAOPoRzdG5nSc/SEU8nyOXWBOauodeHXwCsqMi08KtCoEp3ekCvHerZLxfcRA==
X-Received: by 2002:a92:cd8d:0:b0:331:30ac:f8fe with SMTP id r13-20020a92cd8d000000b0033130acf8femr1094067ilb.3.1683301367445;
        Fri, 05 May 2023 08:42:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i17-20020a02cc51000000b0041650ca49casm26273jaq.83.2023.05.05.08.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 08:42:47 -0700 (PDT)
Message-ID: <59e51f1c-0e66-eca8-fa22-91bdce967897@linuxfoundation.org>
Date:   Fri, 5 May 2023 09:42:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_get_descriptor (2)
To:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+e8db9d9e65feff8fa471@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mailhol.vincent@wanadoo.fr,
        mkl@pengutronix.de, syzkaller-bugs@googlegroups.com,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <000000000000fd3ea305f0644a0b@google.com>
 <000000000000c2922605faf2baeb@google.com>
 <aaf08c6d-b085-4755-afc1-98301106e947@rowland.harvard.edu>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aaf08c6d-b085-4755-afc1-98301106e947@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/23 09:38, Alan Stern wrote:
> This appears to be related to the usbip driver.  At least, the console
> log is full of references to vhci_hcd.0.
> 
> Alan Stern
> 

Thank you. I will take a look.

thanks,
-- Shuah
