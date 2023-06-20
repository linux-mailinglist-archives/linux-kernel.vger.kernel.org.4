Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1995736D47
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjFTN01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjFTN0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:26:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78371718;
        Tue, 20 Jun 2023 06:26:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5196a728d90so6279599a12.0;
        Tue, 20 Jun 2023 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687267564; x=1689859564;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IPaTUj5pEcTFbztNjeiIr+QIhC6HKA9RU60IVRtSiWs=;
        b=qQG8U3EdxAxJW3XEyHis9Y9EIKVX5JhaP23fnCKAZg3tJLo8ZCC/5kCBfVw8FCt6L8
         lF17idAtlMeSiABUI26GK0fzmkFoT9iGfro/cQi49yiBCs8I6BtqwC+/zl8NwTb4f8hp
         paP4gbXtaGnmsASB+yZ4jHxzLK73p2CozKWJo3u00UVz9zoswD6pJyPZ2dlDHWGlSA3v
         YKA0AYL/pRiftgh9GYjrjsD2zeREwLS3nUREczcAdh8Tf6bdPYscme/TOW6bS0ZR2Gew
         jzDVmIXkz09bSJmZYOGK1+eHpc95ql/42MQZZ3bW2eWW3e8+eH3tbaB6M70CuSD0M4ot
         vB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267564; x=1689859564;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPaTUj5pEcTFbztNjeiIr+QIhC6HKA9RU60IVRtSiWs=;
        b=CGsHz98YxgMX6RW3jdb17C4l1wuivNCRUIUBdgv1/8g6rKVjbincFGInHjqWpGB8rq
         CNEI1vvmYdvYWpkZSJZLSRDiWJ0cBft0At81ygvJ5z7fZBW2Y8Cy/X+3+hSKlOkP1m2S
         61hUQ08n1JmfvS4l1LAVe64WNRAiUI5ZJD/l2ggGaj3db8oUcI3mJo1Awd0YUSvzXR7S
         uqnBml19JK2q8MlPlkXV5qoggCWZE/8Uwbp5/dtGwxm6ePvQ7hKta0Ig3l/VV6/bVQ7Z
         XlF3qQ4WkXWiluHxX8Ukb+n/VrYIE7H1kaWVpigHORe0MttUkjHi8mE2K4evvaclsHCE
         PFwQ==
X-Gm-Message-State: AC+VfDwXWQH7ECTqQMD+T83863EHy7wJvhPOC3eI2C3zg6xya2TbLVm8
        hiRsLzR3g5BZjRhq3QMuEmz4GzwSycxfAMSWmP3WdiisCJQ=
X-Google-Smtp-Source: ACHHUZ5UXrb42EtfrSi6eUbr/A6TSZ6RyCP5szc8spZeltVx3rKadZBg972Ya0mPjCa21LQwjtMjeMxtYe2nCRVMvSw=
X-Received: by 2002:a05:6402:1acd:b0:51a:453b:a493 with SMTP id
 ba13-20020a0564021acd00b0051a453ba493mr6472200edb.37.1687267563978; Tue, 20
 Jun 2023 06:26:03 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Lewis <elatllat@gmail.com>
Date:   Tue, 20 Jun 2023 09:25:52 -0400
Message-ID: <CA+3zgmsC2qKph_wDfknSa5eq6EnJqxzzj4K7G4_ZxGr5ZQTqbA@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/89] 5.10.185-rc1 review
To:     osmtendev@gmail.com, Greg KH <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it intentional and acceptable for dmesg to now log 14 "Failed to
create debugfs directory" messages?

I assume it's related to "regulator: Fix error checking for debugfs_create_dir".

dmesg 398 lines: diff ./5.10.184-rc1-dirty.txt ./5.10.185-rc1-dirty.txt
19a20
> 12V: Failed to create debugfs directory
20a22
> 5V: Failed to create debugfs directory
69a72
> FLASH_1V8: Failed to create debugfs directory
72a76
> HUB_5V: Failed to create debugfs directory
121a126,127
> TFLASH_VDD: Failed to create debugfs directory
> TF_IO: Failed to create debugfs directory
122a129
> USB_PWR_EN: Failed to create debugfs directory
123a131
> VCC_1V8: Failed to create debugfs directory
124a133
> VCC_3V3: Failed to create debugfs directory
125a135
> VDDAO_1V8: Failed to create debugfs directory
126a137
> VDDAO_3V3: Failed to create debugfs directory
127a139
> VDDCPU: Failed to create debugfs directory
278a291,292
> regulator-dummy: Failed to create debugfs directory
> regulator: Failed to create debugfs directory

kselftest 270 tests: diff ./out_5.10.184-rc1-dirty.txt
./out_5.10.185-rc1-dirty.txt

ltp 865 tests: diff ./out_5.10.184-rc1-dirty.txt ./out_5.10.185-rc1-dirty.txt
