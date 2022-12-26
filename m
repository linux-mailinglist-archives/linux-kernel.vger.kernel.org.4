Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6B6656032
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 06:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiLZFrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 00:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLZFrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 00:47:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A87260A;
        Sun, 25 Dec 2022 21:47:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so9878031pjj.4;
        Sun, 25 Dec 2022 21:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uLSvcKUr/LzSUoeSULqWf9KKBJSvPiEYMba+dOztS9o=;
        b=byes3/YMeMFY8pdHEKz8Gs/g8Yy7sGiGQ4Y6gjhniUhuANAyCrF3y06fynIumCQosc
         esDeoH0ocS1+LUY8jCkoxZ3aDFxyiItmohAl77wacBOEgwMO5+Yuv4Yycx3akTapUiQt
         AYJNf8Z7wysPsQApsaNsZNw1OwjMIgPvDkT7MMjy7dHLe8DHxf7PpvIfIUWaE+BgPG3b
         05doglK0ZFJDMOs3sWhbbFl6rVZclTJ4EEsDiqWCCinCorxxX4Fe685tds1pAnY6DiH8
         fFRlzm0lQviQ6Y2iTakjaFSxccIJ5KBreqSv+PRdPIKkR3ZfUiZxrOi4AgUO6ocWAKCL
         lOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLSvcKUr/LzSUoeSULqWf9KKBJSvPiEYMba+dOztS9o=;
        b=Lz8RKK7vgITF379G/aILIGQYwF88vAbfHOSYU8dtqTB+/gw6m7zKVi0ktjloWx2P0z
         IWjgRsk3iuLWNvRtIY/FJGoicNjfvIOVz5X9Yoy4qg4PJblG9tafnbxUvfz8MGzj2fx1
         l1z3ZQKqoMoMZ6ljSmvhp8pFOKETgcFFvypvKW/pJtR03BBkiLx2X+1N86bu66R5kefk
         0Ioh4On7clJqhTSdvixIOsXeopKNRgVRDEJtYOnoUof2ls87s2SbgvoMDsFH2c3sggoh
         Uz7OSd9cU17mHvacWMVMFp0A3HGACovJDHtqcaKLDnyNmwGYcO1/HjSeEG7Hx1uGevHV
         97UA==
X-Gm-Message-State: AFqh2kpf6GMTLDOU1wkCRFVyWZJljXmKikxFH41uZ6L+O+BjNohKD+Rb
        zdUm6tMieymvqxu8ZxEYL1E=
X-Google-Smtp-Source: AMrXdXuBted3i4+UVKCqyGp2Q7zGVCsdurIC+MAFR9FedgpvSKF7wRz2qQ87sbh7EYngvNMpWlHARg==
X-Received: by 2002:a05:6a20:9e05:b0:af:9391:449 with SMTP id ms5-20020a056a209e0500b000af93910449mr21599493pzb.45.1672033668239;
        Sun, 25 Dec 2022 21:47:48 -0800 (PST)
Received: from localhost.localdomain (1-34-79-176.hinet-ip.hinet.net. [1.34.79.176])
        by smtp.gmail.com with ESMTPSA id h35-20020a632123000000b004785d99321asm5618242pgh.86.2022.12.25.21.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 21:47:47 -0800 (PST)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: bletchley: Update Bletchley devicetree
Date:   Mon, 26 Dec 2022 13:45:33 +0800
Message-Id: <20221226054535.2836110-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Bletchley BMC devicetree.

Potin Lai (2):
  ARM: dts: aspeed: bletchley: rename flash1 label
  ARM: dts: aspeed: bletchley: enable wdtrst1

 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.31.1

