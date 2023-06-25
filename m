Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF3173D137
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 15:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFYNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 09:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFYNxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 09:53:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DED1B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 06:53:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50c079eb705so533020a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687701232; x=1690293232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0e0pXKXKCDPEsLE7K22OHRMlMkpy/gOjYbTMZCeW+Ck=;
        b=Z8jlnRFlbnUN5x4vCl6hIce6TZ6FLk058KyzBj+qLwBFAqIimQrk0QF0zVos201AqG
         k77QaJEMPyX//3ml0ikSo181j9w/Ue1T3Dn3F8Rs9W/pAmychPNLw+9WkpfsCCy4nx/1
         CxFN+qzbGQ3k9BNGHMZTCJTU9t3MAf48M06v9Mwlwo2qSGhYDVJeC5A9IOewCwTyK+Gh
         EyxtR7CzWkNwTAjrjpY2MekQsl4fZ2rz2AIMsu5Z5r8s7qP/c+kaTubGdeEJTFRpMre+
         /WTeBYehHygqAHy+dyCgkRWy2kwCfkMMMIFjNTOK18fj10l72KERmMfuGb+dSXWIZ5yr
         YnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687701232; x=1690293232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0e0pXKXKCDPEsLE7K22OHRMlMkpy/gOjYbTMZCeW+Ck=;
        b=ZN8qQ1gcG5tbuY7T6mr0qI8Qc/Pt5PfE9/vrwjBsMgirNRjHwVuirltGVJD/NS7HsI
         J4FmW0yXjmtrmNBxH7iu8rxmMOSYxHIYz7IzxhGXonAmVZSfDs/RxC1gpkWr6UzPSwA3
         mdvVL+FlgK6LQ/9tqOxVYlb4c++4Py524q7KPa7jD3mN7M3xOjRwgNgCy/JUP6KHX6KT
         ah7yhQATtjiS7VJ+45jk8Z0fJm9wRn64XIe4Bnd2sPTk+5F2uyDjy7+J5RUkeO5UfEgu
         SRoawonTjZ/ylK6WGs8/OP8CXRzxafBZbrQgQYmOMLzmq4jqZW3j7k+HctoWSerB5t3P
         GqDQ==
X-Gm-Message-State: AC+VfDzbIkBZFcCXL3+C7bAWMD9Ok67c7l6ETy/4Qj/53B1rVgW19PL4
        qDtqsKP3FaJLXUeXRg76bTU=
X-Google-Smtp-Source: ACHHUZ6gRGaj8CmMP5OiUdZSJOOz009LavNEvPAaZCowyc0pATarqRGnruCUsCUfxNjdFeVyiWvVIQ==
X-Received: by 2002:a05:6402:42cf:b0:516:39bf:1223 with SMTP id i15-20020a05640242cf00b0051639bf1223mr22336730edc.2.1687701231917;
        Sun, 25 Jun 2023 06:53:51 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id f23-20020a05640214d700b0051bc58b8dbcsm1783471edx.59.2023.06.25.06.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 06:53:51 -0700 (PDT)
Message-ID: <6469d93a-585a-06e8-a441-84f738f08c69@gmail.com>
Date:   Sun, 25 Jun 2023 15:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/5] Fix some checkpatch issues
To:     =?UTF-8?Q?Franziska_N=c3=a4pelt?= 
        <franziska.naepelt@googlemail.com>
Cc:     eperi1024@gmail.com,
        =?UTF-8?Q?Franziska_N=c3=a4pelt?= <franziska.naepelt@gmail.com>,
        hdegoede@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        quic_vjakkam@quicinc.com, tegongkang@gmail.com,
        gregkh@linuxfoundation.org
References: <F9C4E29E-C355-4B08-A2EC-2197A6EB7AFD@googlemail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <F9C4E29E-C355-4B08-A2EC-2197A6EB7AFD@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 15:33, Franziska Näpelt wrote:
> Thanks for your feedback :)
> Since not all the patches of my first patch series have been applied, I thought I have to submit the whole series again. Submitting a series of 5 patches, where 3 have been already applied of course fails.
> So does it mean, if 3 of 5 patches of a series have been applied and I want to submit a new version, I only submit patches for the remaining work and not all of them again?
yes
> 
> Thanks, Franziska

Hi Franziska,

please only submit the not applied patches because the others cannot be 
applied anymore.

Thanks

Bye Philipp
