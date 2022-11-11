Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E42626277
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiKKT7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKT7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:59:48 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF55D2A247
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:59:46 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id e129so5164099pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ElnrwqNrmEmGxc+Sty+CfPe+tKKOnn1Ink+Om4QXeRY=;
        b=k98VqU8gxjfX1untl/8fhYQhAKmTuEGg7oHaMmIXlGUpl0Slq4slRoQOu+7jRiCZUW
         e2erGpm8620B/GtlcWJNr1RjDflo2fmcx/8ACJAVE5PbOE6BQkj7XWCSDNgi2wPTYAUY
         QZ+zOlEqPkI8A9OOLu83sdLnuSbnDeI0oa2NEtVk3Bn+DEt0tZZjNLV+WxmafTpTr7Rc
         8/eYesey0jPFrOa70E0oWUSHzeM3QyermomBftmuNZyYD7nWY7gLiPHW97cVe915qDXW
         enX8ZxQ+yd+KeiqRnbEXRmkF1KGtsGs8Ex+iiN3vqSuUPACdHZpX8lQuxi0utlDVANX6
         UFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElnrwqNrmEmGxc+Sty+CfPe+tKKOnn1Ink+Om4QXeRY=;
        b=ZYojBWh7IObNC5a3y7vWwNKWojx5JNedCG3dcCQ4kVKOFgbJ2af0MwHxo8sZ6KOkAr
         4veTNLRyA3J2nmOegZ6h6PzV+SJ9HOnJ2TPVrMXZfaW54UMv7hXyIcIXtmFsxvbTDvuY
         5NPCv3c5lGiP6ldNiDHL+qp+oyZBrjxjEDupqa67vpdGpNcAdUoopi7h6J61Dtx4GT9T
         qErkJ8limDmrFc4xkAD9XanPnUi2ka7nB+CYf5qxcAI/Egi9FVsN82ihtzeidSiEfVKN
         7izsu0khaFDD79+1ePBEBmcCyNaqXCbySoAHTlG4w5oNYky+OGf6l3YFnd4OtIuep1p+
         DhcQ==
X-Gm-Message-State: ANoB5pnbvGWSH9vobPbSWtJzpiyePrnS5Z7G1Rd1VROa0KBgE3eYxRB6
        YVSZrLfMX3aJMhZ6fzpKnUpHvw==
X-Google-Smtp-Source: AA0mqf7w+H3r79go//zvI2a+oSkmnoBULdoqTpMYvgSGFFr0ze8jGAa/pSXOXq9IT9R5GI2IzycUwA==
X-Received: by 2002:a63:3109:0:b0:470:90f1:6219 with SMTP id x9-20020a633109000000b0047090f16219mr3046035pgx.256.1668196786409;
        Fri, 11 Nov 2022 11:59:46 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79901000000b005360da6b26bsm1954866pff.159.2022.11.11.11.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:59:45 -0800 (PST)
From:   debug@rivosinc.com
To:     palmer@dabbelt.com
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        debug@rivosinc.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux@rivosinc.com
Subject: Updating python gdb command lx_current for riscv 
Date:   Fri, 11 Nov 2022 11:59:37 -0800
Message-Id: <20221111195938.1499148-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/gdb has a good deal of useful commands to locate critical kernel
data structures from gdb. lx_current misses support for locating current
task on this cpu. This patch fixes that.
It's a small patch. Please merge.


