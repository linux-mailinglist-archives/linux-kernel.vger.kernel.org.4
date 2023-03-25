Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE686C90A5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 21:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCYUPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCYUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 16:15:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054924680;
        Sat, 25 Mar 2023 13:15:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u10so4926162plz.7;
        Sat, 25 Mar 2023 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679775336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GynnLGwZMbxNI26jMYN/r8iX51c7YhYkKStLbWeQRLo=;
        b=atrmOeiYQpvjjBfOuA9YWxmwGx9ptCjyJUp0uRUIQBmPc9fiGz2R8mUxpxNt7s2F+J
         aWGtEIzjIeyovO2rJqMF5WGrI7jDmuLlYQA15EurbkjC8admVfTq7ZB6iiKOvOboRlCz
         Drxl3GxYDlaI+6w6TOqWcZ7Vg8rsIM8+34IHqUx41VZv16GrldK/GRAFi2e7uOt0O3NT
         yDAYQkibwBXSllAcK8RsSyIqc47z6xxq6dyX4wHCbqS6yUQTXKdG1gYL34inGdvBSGQF
         hOUpfUKUo2pSivKftWRsINGLk77myY4mnNQYE4r4eXzDCSZC8+qChUsqXCKixxlL4K1l
         Vmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679775336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GynnLGwZMbxNI26jMYN/r8iX51c7YhYkKStLbWeQRLo=;
        b=YYKZwS63xfBLDc5Lw0Gwat6S+64LnsDREJsO1KZf4Dpls8yMnrwyQmzk0R6M7NktYe
         /0YKvjGLHa1mqTE/vmZ2WEqBZUyUbAe48BRt0rIoRcurqxWOKfhB7iA1Fo9CxjGnmnZq
         yiLFUw0Z5nLTzfxXesVEIu5B5xh5WaTgnuRtbvlwVtK761agDh3KA6xA2cYKEloot1ln
         h61rYjB8lRNfEASVp/G/yHKTbAuNJz+zb1J2lS5lfeObudewX9B4L7tGHEt/PqOjiL9Y
         M+OoyJqU8o5BvjbnGdYYP/y1Phc7R4WBNtTV3+wtQICEoy1axp9doNY8afkc+Gb0JAlW
         megw==
X-Gm-Message-State: AAQBX9dQf5T25GO9e+y6/WdZi2Qcc14KDByMnPv53G93mO2nbR6qDisw
        8Fjgr+4yJlFbH8keonyowHqYV1Z88Tic8LKO
X-Google-Smtp-Source: AKy350ZwCXg2+eAH5gibMUxQymcbwVRsrBiQvmO21J9lujKijFkVdRa7PdcDqLOHLQGCaj0A8J4LiQ==
X-Received: by 2002:a17:902:d503:b0:1a1:b8ff:5552 with SMTP id b3-20020a170902d50300b001a1b8ff5552mr9488134plg.6.1679775336507;
        Sat, 25 Mar 2023 13:15:36 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:dbe7:6935:261d:5dd6])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902b19800b0019e5fc21663sm16103643plr.218.2023.03.25.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 13:15:36 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     danascape@gmail.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shengjiu.wang@nxp.com
Subject: Re: [PATCH] ASoC: dt-bindings: ak4458: Convert to dtschema
Date:   Sun, 26 Mar 2023 01:45:31 +0530
Message-Id: <20230325201531.13037-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230325201007.13006-1-danascape@gmail.com>
References: <20230325201007.13006-1-danascape@gmail.com>
MIME-Version: 1.0
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

> +  dsd-path:
> +    description: Select DSD input pins for ak4497
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    oneOf:
> +      - const: 0
> +        description: select #16, #17, #19 pins
> +      - const: 1
> +        description: select #3, #4, #5 pins

I hope if you can review this part correctly.

Thank you,

Saalim
