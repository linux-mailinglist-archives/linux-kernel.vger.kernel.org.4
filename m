Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1189A6057C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJTG5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJTG5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:57:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880D4122BEA;
        Wed, 19 Oct 2022 23:57:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d10so19454886pfh.6;
        Wed, 19 Oct 2022 23:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtQ3MJfH9rjvVOvXyzykbW+RsXW9Ha1tJz6/FEzjYe0=;
        b=aqqt/RDH6PinjKdgxnid7b0P8/b8wP4AfrTlUy9j78iO6yXZBFLV1Zo9nEUR5ki+kO
         AQifUIX1SyszwAdwRWhLdiXzdrZI8/WdQY1Iv/HfXoyD/yeZDsKkwkzQO5ahDvg7L98N
         DQvyjv4zt9K+iioNFm5iIMNM95kfyotg+17MxmDHwn3zh4D6YOsDHlifp2bqcQWe2dRv
         8fa2j6JFxrBIYHu6shadIhuysrLrQqr9ry2vi2JoNocGRctCiGSHF69DwNUli+ogzxH7
         gIblX1r9Cp9v2UlLY7d0zPsHXjPDbgywa6v4NXo6E08ulfkVFy37xiABtAo4BZ44dn5F
         3Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtQ3MJfH9rjvVOvXyzykbW+RsXW9Ha1tJz6/FEzjYe0=;
        b=3AFZn7sHoTttGWDc+TinVmubSkaTLyo9ycSXWhMARBRoA+gDx811xOHhTiQ/owGBGR
         wj6rnEXm9iN5cQtTWel39wOI1IrkQZlKlZTrYsRzNbn6j+yArOxWXBe3ChPuoR+S5kU7
         dbUvZKocz+/eSyr2dVjD83wUdaDxkfjGIZJ9dehUSWgt8o0SCiP6wMUm9iDFDF22dx9W
         Fn53NYA7uj4Nn9VxLmyWgHhK/k+vEzZNbKPENBQjZ4mIO2+RunGXUlhSKtsmDbH6NfjP
         OmdRizyLl+UCN24ZVGaRNZAmnuALZpryYZVUI7AhU5jRpMLxAgmhUyUn5ZGRbmAj6AM9
         z/SA==
X-Gm-Message-State: ACrzQf3AmAV4ZPTr/S8fAC9eQyayMlJ2jIaD83+2wdn90BOQmxvgwG/a
        E1y7KOohk9tG1NvyQseNqlg=
X-Google-Smtp-Source: AMsMyM7Cdt9mrXMVPbtEF0lTp80jZkFM5FLTNrnrqRB/4/YfwQPbsR8RqL3ibHXIPF6glI7c6ShLSA==
X-Received: by 2002:a05:6a00:230d:b0:53d:c198:6ad7 with SMTP id h13-20020a056a00230d00b0053dc1986ad7mr12846137pfh.67.1666249040808;
        Wed, 19 Oct 2022 23:57:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:a12c:444a:ed28:4831:fc95])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902ea0900b001786b712bf7sm989952plg.151.2022.10.19.23.57.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2022 23:57:20 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for Richtek RT6190 36V 4-wwtich regulator
Date:   Thu, 20 Oct 2022 14:57:11 +0800
Message-Id: <1666249033-12219-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

The RT6190 is a 4-switch Buck-Boost controller designed for USB power delivery
(USB PD). It operates with wide input voltage range from 4.5V to 36V, and the
output voltage can be programmable between 3V and 36V. It implements peak
current mode control mechanism to deliver up to 100W power with the
programmable constant voltage and constant current output. It also has built-in
charge pumps for driving external low-cost N-MOSFETs to control the power path.

ChiYuan Huang (2):
  dt-bindings: regulator: Add bindings for Richtek RT6190 regulator
  regulator: rt6190: Add support for Richtek RT6190 regulator

 .../regulator/richtek,rt6190-regulator.yaml        |  77 ++++
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rt6190-regulator.c               | 495 +++++++++++++++++++++
 4 files changed, 584 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6190-regulator.yaml
 create mode 100644 drivers/regulator/rt6190-regulator.c

-- 
2.7.4

