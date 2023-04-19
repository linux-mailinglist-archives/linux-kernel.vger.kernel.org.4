Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A6D6E7365
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjDSGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjDSGg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:36:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD047ABA;
        Tue, 18 Apr 2023 23:36:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fw22-20020a17090b129600b00247255b2f40so385638pjb.1;
        Tue, 18 Apr 2023 23:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681886175; x=1684478175;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zXK+1vRx9QMpgXCr930A/TsI7m3oR2Bm7MqsJ9nzgTM=;
        b=G+/OyadIQrUEU4/UmVimFgG2gZJVOKuL8+s6Pox2wK+FNzxfX8QR351KYMeBBpKRKw
         ZzYiKXc6lbAN3Cse20Aw89bUnnDwzdZGY8+3vDlvXZkwN7VE+svoYkuyCt1QtG9Ct3aE
         WmjNrk5GeH0MMGTfakSTyi6b/Do1N2nrr+LTzRwxiNpPXwOJF5Q9v/NOlD8IpI3JImFh
         JQQpV9RxXBCp7cFodjycKbzkhhpw6psWwRhYiVCFOzBvWeqacq6wC16rqE9GeXrXw/r7
         XZfdNvJt5lKML+O2XjrMcFwl9Wwv6lCP5XswSPUdu5ftjUm4try51ef135CR1RkBTzj/
         QQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681886175; x=1684478175;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXK+1vRx9QMpgXCr930A/TsI7m3oR2Bm7MqsJ9nzgTM=;
        b=hLLynCDoFvnzkTLeaxoi2iul8DDRsE+8u75VeX6q2tZ3/qA5a82bnSjn5Dy0zRtM55
         5V/+AOtyo2hgakzESG2lfkKgRQn9vTS06E8dDW7KARuxAnm2G0C5oDVvrMXt/xODulE9
         UObziJ6B2Wm2jNhkHRnTe/AUslmTLKl3ZRQGnDqfREdz7GGeSRKqBMJh4xtjNWVuhZhu
         J2ntKwMytHZ/zdDxDtDG492+Xd9XyQoNHKwpdg7mvJl6EkF86NskK+t0rsMAejCSBV6f
         sxD/GuvaacVCj2wlmyez+aiAfI1wUHU3CS3gowc4agoVYuw6LmHEu37Jv3e1ZVo4gITP
         y4sg==
X-Gm-Message-State: AAQBX9eV6lB9k9UE4dOu/c+3hp9wZ8JTnneE34/5s9ENGpayX65IhJYO
        BnoYBSaWvteDeVDHUkXwsFavm1zIXQc=
X-Google-Smtp-Source: AKy350bFxiRN9NtcdN9rQ/FH/SMa+2/szgPQxnfHRdTJqu5oYeS26kb8QoMmvwPwKi4AJiZpofxTnA==
X-Received: by 2002:a05:6a20:1448:b0:f0:3e78:715b with SMTP id a8-20020a056a20144800b000f03e78715bmr2512613pzi.40.1681886175123;
        Tue, 18 Apr 2023 23:36:15 -0700 (PDT)
Received: from [192.168.127.3] ([103.133.200.235])
        by smtp.gmail.com with ESMTPSA id l35-20020a635723000000b0051815eae23esm9405961pgb.27.2023.04.18.23.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 23:36:14 -0700 (PDT)
Date:   Wed, 19 Apr 2023 12:36:03 +0600
From:   Mubashshir <ahmubashshir@gmail.com>
Subject: Re: [PATCH v3] staging: HID: Add ShanWan USB WirelessGamepad driver
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Huseyin BIYIK <huseyinbiyik@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Message-Id: <3ONCTR.Q80RY3TDW2I8@gmail.com>
In-Reply-To: <20230413161305.ywthwbu3ta3mv66b@mail.corp.redhat.com>
References: <39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir@gmail.com>
        <fd1961a773558930b6ae0aa2f6fc7f84833ee634.1681131540.git.ahmubashshir@gmail.com>
        <20230413161305.ywthwbu3ta3mv66b@mail.corp.redhat.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13 2023 at 06:13:05 PM +02:00:00, Benjamin Tissoires 
<benjamin.tissoires@redhat.com> wrote:
> What's the point of keeping it opened for the lifetime of the device? 
> Do
> you really need this?
> 
>>  +	if (error) {
>>  +		dev_err(&hdev->dev, "hw open failed\n");
>>  +		hid_hw_stop(hdev);
>>  +		return error;
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static void shanwan_remove(struct hid_device *hdev)
>>  +{
>>  +	hid_hw_close(hdev);
> 
> If you can drop the last hid_hw_open/close, then you can entirely skip
> the ->remove().

Would hid_hw_request work without open device?


