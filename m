Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B737B6C68B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjCWMpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCWMpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:45:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8484311B;
        Thu, 23 Mar 2023 05:45:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so1026363wmq.2;
        Thu, 23 Mar 2023 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQAQqByVAfmFm3DU3NaNbOMQ1oSxcBn7+GrE//RQMVI=;
        b=i7Ck+oQM9NQ0o/40CWEKutNaf3I1dTIPcGRZ5OsO31ggX6ege909sCo/b4giY9Jr7G
         KnqFlJWhs23pvdIQZrgSkLK12GS0AIAqeLeerydkN5MFF/YmBDmvXvqsAoqgQOPMneBM
         67tfNLmGCvaoiCHcZCgLdiuHAFa1cye3gQq347GDioCbQN4iBgLqQIavk4iBBq7dNqOx
         y07JF47WgdcyhtXc279MIBEO4ZMWXqpYFIw8ebfSWiD9D/VidwcQUq74ExG1cpjEM3ut
         ba+XTeeCnxyl5tmJeSXfNSOyU+bemt+wB9jcIVWNEy+HObJuTMtq7eMtqBjI35Vo6T55
         1pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQAQqByVAfmFm3DU3NaNbOMQ1oSxcBn7+GrE//RQMVI=;
        b=StXnMlf/lPYSaMg9CbC3lwTrhiHn/gRI8h+LlHvY1melvAyU6FrSzRzrXmkW+AumrU
         irfpfAR7DC/KIz/zfiHHYcb4GbHvt4Vif3hYeFwQvqwkRqP/co0ZigM/kJX8fWbgg6uw
         gCRVinYTITi6qowxOwU4tHHhvj8wzQ/QiNIb5LYAyv2oJIFobWy+LGmXU3WrM/c2h8t8
         /+8aS67v4n55713+MiDrkrZNl7jjTwUtLgEnsNd9IVrE7JdEBBdwzYLq1boSSCNW8pmM
         Dqk2IMB3pob3q8QE03eTMAZSQtov4MEHnaD6BwVPcNZkLTykJwBLYAzdMecMPKL5dstp
         YcLw==
X-Gm-Message-State: AO0yUKWhk0GqR1o0E4hU/2v/VXW5UHQxhXf1L41KWSuibtnoo+vCO5bq
        O8FmRmY9yOBgBVSmzH6xxaU=
X-Google-Smtp-Source: AK7set8OZ06UGqX7C9zxBNwCmbwThgLUts/p8I3JzlN/dTP6p8ZS8bMug+WVnPOXu6H0eH51ney3ow==
X-Received: by 2002:a7b:c457:0:b0:3ea:e582:48dd with SMTP id l23-20020a7bc457000000b003eae58248ddmr2211647wmi.34.1679575512920;
        Thu, 23 Mar 2023 05:45:12 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c1c0900b003ee6aa4e6a9sm1942939wms.5.2023.03.23.05.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:45:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        masonccyang@mxic.com.tw, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 0/2] mtd: nand: raw: macronix: allow disabling block protection
Date:   Thu, 23 Mar 2023 13:45:08 +0100
Message-Id: <20230323124510.2484808-1-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices hang when block protection is enabled, so let's add a boolean
property to allow disabling it.

Álvaro Fernández Rojas (2):
  dt-bindings: mtd: nand: Macronix: document new binding
  mtd: nand: raw: macronix: allow disabling block protection

 Documentation/devicetree/bindings/mtd/nand-macronix.txt | 3 +++
 drivers/mtd/nand/raw/nand_macronix.c                    | 4 ++++
 2 files changed, 7 insertions(+)

-- 
2.30.2

