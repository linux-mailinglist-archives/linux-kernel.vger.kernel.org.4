Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C3E7107D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbjEYIo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240349AbjEYIo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:44:26 -0400
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09640194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1685003963;
        bh=tEQWaxq6Ha5MXVh4iV4Tro6MvbRM2LfrwgYVeGuO2g4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GOjwISLGRjBaSHEgt7RgD8yBS+zW9txyBlYDfC7H2pq2fpKpJhieOSq0FQjRMEwPf
         DDXAtgWDkSjVHgjIkD7YMVM0CtghALamo8sGnlKH9LfEPtsncf3Wpu2z86RIDDYpqq
         KeZ+2AHe6uzrfJCpJjfU4yX7gMUfV3VPv8N+nml8=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 9D313EBB; Thu, 25 May 2023 16:39:19 +0800
X-QQ-mid: xmsmtpt1685003959tq159wqmi
Message-ID: <tencent_7E0D8A843CB2682FBD54CA5E6F478F11A309@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjkQVDc0WwmzqezxNXCZg+rFs8s0QTMXrvoC0agmhA0LBqLkLgds
         L0p7xyZRtKqD9lmNizoYn4e2o+tPIKq8EeARBcrnnfniwWalnU3BmDGYaOA1Fmhirm4zaMKRKSHC
         2SDXeDAEWeXOti2tsCAOzkzm8GgwixxhgvGpqVnDbxKUFAjK0PpqyteLJpFuUKPDLaAfWeBxadUY
         Z9zZe866aAogVUW5hMouIbAJtswuZOI0ssLfTBJzVKNDAsgkHrNCtx9VoMp+jmABq9pb7ggqod6w
         FLloLZCgU544lgtY0U2LA5CxB5cNZ92LPshfhZwm7WsqQKWIiLRBHM0UPLIzbqpVVAiVvZBcuc05
         5LrnUjgQVk42tvBCG2b3sgdZlQpf+kG6TRL9jwfmhvfpzrb1tEkb3pnlvlJqbpqsXavGxleLYP6E
         xicrO3mlpH4iDTpK9UH9fjFwAAgcp3Mu9ovKPcte+Qld3V7IsZIdCYrr5E7CIiBO/98KGLGhporf
         79LgGfxLFQm/b68LmKDDFw534o8zeB0WBenq+sRJxiPi+YqFIzCP90niq37tNSSS3NWd/CdP5GZA
         qV3/ljmwQPmxJWYhhluk4GcZuFBY27zwJ9+yEO1LeNGrmtZ5okhB/TcMbN7zAgNghHtlrLY2uJNV
         SJDoT7gdJluyAm8AfBYBE7LDLn/kKePZ4FVSufxDrAzXjOhZIiQG1cSKXJew0ELLmJcOjcQ/x2IE
         6gOZvqIpSURGvR76z9eRkhGk2LUKw8gpZZ0fDETOihNase04JOpad/uL65dEYp4OjcX72ToS3LAG
         smV2GVDodPfdVs72huQbbo8DaA2/koS2MaLrRFEla41M9l8mHZCe03Pz2ZVGroxhuNVHNmAr8vbo
         Hnx+f0NWh14dGkMbpt3aOwalvbEVxxZMmyLNHSGbjxv4eFTChyVV89NficLcIKdeWX2cnt8KnI4+
         Z8MJg+XQ7cBX8G/5tljH37mFTqI6IFE/ShPMGDvJJHG0ac2d8qYA==
From:   Rong Tao <rtoax@foxmail.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, linux-kernel@vger.kernel.org,
        rongtao@cestc.cn, rtoax@foxmail.com,
        virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH] tools/virtio: Add .gitignore to ringtest
Date:   Thu, 25 May 2023 16:39:17 +0800
X-OQ-MSGID: <20230525083917.26801-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230525034526-mutt-send-email-mst@kernel.org>
References: <20230525034526-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot, I just submit a v2, please review again.

Rong Tao

