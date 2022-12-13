Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5414764B984
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiLMQWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiLMQWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:22:00 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E12218A3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:21:59 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d7so268295pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncjGKUv9rVKBS01SubO64Vlg5d0EAsJr2WrmHlvF8aI=;
        b=cnUqemJOaNWoqJLcIuYLWCoRsH9YB2t97z2oa9JSDcYgoo0bvs3Kj5CADWkH1OBeYk
         rKCZqnz0LFuYMj8Zzm4oHFWfOGN/TIxEjZr4pGWj6UrjzQB7hJvdC2oyXLIFkJ5fWqf/
         plp009WBpFJF/9BWluCVyOS9kYOIJUGyGnoswOrW45HsmdRhlH9EJvKVuPQOJUTrEqwg
         V06kj/pi4+vrfAYBTkVDyhWhB+boE4BJ+SL6Q8v2pAlOEdCdiStLZRAJ2HeKJRb0Q06v
         IuvfHh1x64RMZCWb+xo50o5sBxXzR0Giz3UyzA0KxixIScFccjVRbwnuEYxFl/LJXhLB
         C7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncjGKUv9rVKBS01SubO64Vlg5d0EAsJr2WrmHlvF8aI=;
        b=MBXYkcy+00GfX6oRmiOn0niLmzle8cnLnOHnwZ4Jz8NThfJGNMzkUyB5K4MXZ0bsZj
         fFaxT4EVNmpuAQpP8JSOK3aiu7UX5J5JRpmRDg7uKoMAHqVmAeIabZIBc6+4RG4/Ksml
         VSMXCNxz+NbmGyWarUaOzwhHQrwBANBqycfniDbYnv8D+tO15UkEy2YbQv57InxeAF3B
         rxLt5Etvk7Sqv5y9GaovxW+/BB3QG84QFuz3uPXQOIEyU0uJtU3hvlrX587+PEzTV5sh
         llFA1u0dWqpdurctyDzzj2Mr0GV6+cfeGjG2HZ+dZzU9RMsjFNB/oAJ3cdmmE0LuTAUL
         q3ng==
X-Gm-Message-State: ANoB5pkmE4iV0vigUppyGsB+AmOt3o5Y9EjpTu2hCZUkwEGpJTJIclxG
        j0BFzEpHhKJHEWqReXx4BQHKcg==
X-Google-Smtp-Source: AA0mqf6q98v/+SKapWr16Y/du8552JbDbZLpSka+p8FGxLVAGnmPE2jwQ0akSy8RoMFoGgo7+YOjZg==
X-Received: by 2002:a05:6a21:3942:b0:a4:c01c:5e1e with SMTP id ac2-20020a056a21394200b000a4c01c5e1emr25872268pzc.47.1670948518785;
        Tue, 13 Dec 2022 08:21:58 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id b27-20020aa7951b000000b00574c54423d3sm8096315pfp.145.2022.12.13.08.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:21:58 -0800 (PST)
In-Reply-To: <20221201135128.1482189-1-alexghiti@rivosinc.com>
References: <20221201135128.1482189-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH 0/1] riscv: Fix P4D_SHIFT definition for 3-level page table mode
Message-Id: <167094850229.7325.7145229658614333981.b4-ty@rivosinc.com>
Date:   Tue, 13 Dec 2022 08:21:42 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>, linux-mm@kvack.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 14:51:27 +0100, Alexandre Ghiti wrote:
> +cc linux-mm since I'm struggling to know how bad is this issue and
> if this should be picked for 6.1-rc8 or not.
> 
> I tested this fix on an Ubuntu kernel in sv39 mode without any issue
> but the version without the fix seems to work fine too, either this is
> not a real issue or I don't exercise the right thing to make it visible.
> 
> [...]

Applied, thanks!

[1/1] riscv: Fix P4D_SHIFT definition for 3-level page table mode
      https://git.kernel.org/palmer/c/71fc3621efc3

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
