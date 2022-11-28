Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77E763B3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiK1UsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiK1UsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:48:05 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B6C1139;
        Mon, 28 Nov 2022 12:48:03 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id s206so12979817oie.3;
        Mon, 28 Nov 2022 12:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5U62yUX1LkeFFB90anRo535cfFCn/K7ulMLvvri2Sg=;
        b=RIqQnYY7EdBcQ+EhiwPjzB66ll0SMe0dWAdKS4aA0xfDEt+5iqJY+CM7JrAlPx4um+
         N0ujTBgmOJH/vdhRu0sRmBnQYOURsOkaMbIQ07IHB9xH4QfExRkPM4b54RBv9Dhfoqf/
         lBMLWiFDJQmjzeQmS86lDKUsO5nXR8Ts/1jFMH/hMTEIJ2bHlJqtjt1Tw2d8Ylq1ywQE
         sIiLehlrggh+qz/X1BQz+5zHxylqQnO3XvxCJ6oppCqSrWJ4dzLz0R1/kFXLQH3DQ/qM
         CeLOmUFh65u3t8Va+YupKBXtcL0I2H6GUkrUSYJTI2zPFYUo20DJLEfcExL8sXePGrGG
         sYwQ==
X-Gm-Message-State: ANoB5pnjzoIKp6KX44ST1TWUxGdpLWmFwlYculUG1ngDthV/4pcIrH1s
        ynhXZOq0LtPS67gFrQR4xA==
X-Google-Smtp-Source: AA0mqf7S2SnK8jX3ckZkHb16mtN8BrcNFoncZx6KwvXq7trmAl/mh202/IyuRB8OGeL8PaT9xeFhMQ==
X-Received: by 2002:aca:de45:0:b0:354:58db:8639 with SMTP id v66-20020acade45000000b0035458db8639mr15437139oig.152.1669668482446;
        Mon, 28 Nov 2022 12:48:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s19-20020a056830125300b00660e833baddsm5221999otp.29.2022.11.28.12.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 12:48:02 -0800 (PST)
Received: (nullmailer pid 1447071 invoked by uid 1000);
        Mon, 28 Nov 2022 20:48:01 -0000
Date:   Mon, 28 Nov 2022 14:48:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.1, take 2
Message-ID: <20221128204801.GA1432027-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull 1 more DT fix for 6.1.

Rob

The following changes since commit 917c362b5f8a6e31ff35719b1bacfc1b76a1fd2f:

  MAINTAINERS: of: collapse overlay entry into main device tree entry (2022-10-13 10:58:09 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.1-2

for you to fetch changes up to 60d865bd5a9b15a3961eb1c08bd4155682a3c81e:

  of: property: decrement node refcount in of_fwnode_get_reference_args() (2022-11-22 17:22:52 -0600)

----------------------------------------------------------------
Devicetree fix for v6.1, take 2:

- Fix DT node reference counting for of_fwnode_get_reference_args()
  exit path

----------------------------------------------------------------
Yang Yingliang (1):
      of: property: decrement node refcount in of_fwnode_get_reference_args()

 drivers/of/property.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
