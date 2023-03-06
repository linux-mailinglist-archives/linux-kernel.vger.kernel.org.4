Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D366AD1F4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCFWsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCFWsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:48:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF302D62
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:48:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h8so12173494plf.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678142914;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2PUC/BxoB7qwCAPqVN+Ej42oH74nlkoVsCW1qtw7mc=;
        b=aw7Rhz9g02YjhDdZ3BLd6m67ejXVqnj6ruaIXalqGoAqsY+L/qOM0AgUMiAB4kITVO
         z+RMoPZp6kcx03oOi95k5TCh9/V9dWSC4OWQ/ah2tSx9T5GjrvTTUalvgbtgyKHQpdNH
         ilsi7B88apqw1MKBjEdlfO55p9nlciV0IlmxKyV0M+7qv9l+x6aSJJ3Fj5JKhjLhIY2I
         xjEtS/RTyX3gkIor+K6By8X2qS+skygRcTKu9JexRNFMyCnfirXn8+TMKKQL3Fvyl/1q
         pO1T22Ag2fvH6ZEdceWdMyStDC+kgeB4/frB9NmpUImsZnSPncD9c2B8I7DAM7khdzLW
         qklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142914;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2PUC/BxoB7qwCAPqVN+Ej42oH74nlkoVsCW1qtw7mc=;
        b=rk2ZPP4eQLdYsTBUbZvsWSvyA3lp4yAX6zcO21A/BWgDkofz9ryAgIcoVujjKOCjPr
         tcYaP0QDwLohJqfjGlYpRMF4oiB/4VlZ4GqFBlcU3+y4cZ06LV5ijEJuLzIJ0MXjmSYE
         jmyVueL68gGaZl4+t4heHNRxAGW8OQvnZ3ikKkc759y3gQHBW/jxG1Bg3ZjOc3K9XZy+
         VKwVAsHo9jDgfiR3aDXdDKP6R5nc7jnOJ0puRQKWDKU1IUmKHzlltgOYqs0rpU+GEN1G
         PrbOMgshaizGspYDH/ub17dw0KJqqFUZTxF4gXl64DynUkZQuu2gQ4KdkRRT9TTT0hMI
         nD1Q==
X-Gm-Message-State: AO0yUKVOBrNbjVOOeOvUme4vudldU6IvmMSsnpdR0RmBgzc+rmPzGog4
        bvI995YcX7JQ+x3JmMFMCq8iYg==
X-Google-Smtp-Source: AK7set8pvRV+c4zoKVLszD+Hz59GPB9xs1KAx+cphhOhNNBx1YnJ3bEiCT45YT2mB2awAX9GfnLsug==
X-Received: by 2002:a17:902:f54c:b0:19a:8304:21eb with SMTP id h12-20020a170902f54c00b0019a830421ebmr18203598plf.6.1678142913951;
        Mon, 06 Mar 2023 14:48:33 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y8-20020a655a08000000b00502e48db9aesm6660230pgs.53.2023.03.06.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 14:48:33 -0800 (PST)
Date:   Mon, 06 Mar 2023 14:48:33 -0800 (PST)
X-Google-Original-Date: Mon, 06 Mar 2023 14:47:45 PST (-0800)
Subject:     Re: [PATCH v3 1/3] clk: k210: remove an implicit 64-bit division
In-Reply-To: <774cb6d15fef0e0b41e7a071eedef980.sboyd@kernel.org>
CC:     mr.bossman075@gmail.com, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mr.Bossman075@gmail.com, ustcymgu@gmail.com, damien.lemoal@wdc.com,
        mturquette@baylibre.com, wbx@openadk.org, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, lkp@intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sboyd@kernel.org
Message-ID: <mhng-8b4fc148-76c1-4dae-b5ab-34f218e7ffe6@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2023 14:41:11 PST (-0800), sboyd@kernel.org wrote:
> Quoting Jesse Taube (2023-02-28 16:26:55)
>> From: Conor Dooley <conor.dooley@microchip.com>
>> 
>> The K210 clock driver depends on SOC_CANAAN, which is only selectable
>> when !MMU on RISC-V. !MMU is not possible on 32-bit yet, but patches
>> have been sent for its enabling. The kernel test robot reported this
>> implicit 64-bit division there.
>> 
>> Replace the implicit division with an explicit one.
>> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel.com/
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>> ---
>
> Seems better to merge this one-liner earlier to unblock 32-bit.
>
> Applied to clk-fixes

Thanks!
