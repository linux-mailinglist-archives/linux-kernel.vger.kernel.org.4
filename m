Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834366D4164
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjDCJ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjDCJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:55:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A336D213E;
        Mon,  3 Apr 2023 02:55:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so29948554pjb.0;
        Mon, 03 Apr 2023 02:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680515729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01YW6j9QbsBH60bpsALo7q/4eL9AmWqz/jdrOcUPAps=;
        b=NIUhHe6NfhPqX4cy71+HFM2TVzxSeaWJarnlnPOjmtZb/lle4mr7/aMYuQJhv6L4g1
         j7orGjNNt2CPsu/Vtm8w/LJURydxnJNfVYw8x2iu5LMRIn+rftKkICWjPvhAE7T4Pxte
         HuxHILEfCLuFJR67dTl3t5QzZ6Xwj78P1WH30QfXecjmOPGmIzFjsrA0SySwWWlXseyu
         6ZcvaMcSB/Qde+jiEw/7XRL+18EZZ+HZLgQzV8L+7vqpoginpfoXo3TmUdT6alkgJrKT
         JV07C+MQofuqUVRk+KlRw49ArXhm417uRCCq1EmZVMITu3pqBiWgp3vOU5c8vbadlmZy
         XzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01YW6j9QbsBH60bpsALo7q/4eL9AmWqz/jdrOcUPAps=;
        b=J1G2vP5O3tZvACva98+VkjYJhBHKl4PauoDYYwGo+HwZEXH2RteHad7xfS1MOfEdP5
         XpPQKH7UOoJ2mlRD9HEzspd588FmUASDdC70kwbtGAKBy5wdEaMrO5iBGpCQhmSTFnC2
         HyAX2NUQzMfO8yqHQfq+AHhL3nuis8LHW+jeJqYre6U0KdAGuI5J6bpShWJzb/pwBwF2
         9FIcGd5cD0yF9eGsIGpw4N+0Kcjwg7JYsffZmXJ02NX17iO2pCSlwTr1y6+e0FF7Adp/
         kx3RHcMWfUEZsTswyouMwquIfUAimBBHFNrz/xg/OqW7FqnyBB1TIF6fkGcwqtbPZ6pt
         rp/g==
X-Gm-Message-State: AO0yUKWu6rpz8HrXvducfGFfx0Em7M857LbIyyf+S/ILrNR6FoTzTA8A
        /PeZWYtM7nb6nPQM9SV3cAw=
X-Google-Smtp-Source: AK7set8Ttkwf/6RsLkHaQufq9oMn7ZWpapgHzwfOcKUajDBBaul5M+vpZ/Erll/wVWd9sDqik3wl+g==
X-Received: by 2002:a05:6a20:e13:b0:d6:7d3a:c6e with SMTP id ej19-20020a056a200e1300b000d67d3a0c6emr30476305pzb.44.1680515728864;
        Mon, 03 Apr 2023 02:55:28 -0700 (PDT)
Received: from pavilion.. ([2409:40f2:100f:dc7:7de5:f2e3:4932:541])
        by smtp.gmail.com with ESMTPSA id p11-20020a62ab0b000000b0059085684b54sm6729798pff.140.2023.04.03.02.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 02:55:28 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        robh+dt@kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: wm8510: Convert to dtschema
Date:   Mon,  3 Apr 2023 15:25:20 +0530
Message-Id: <20230403095520.3046-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9acb38db-bdef-bfc0-5de0-c248d45714ae@linaro.org>
References: <9acb38db-bdef-bfc0-5de0-c248d45714ae@linaro.org>
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

> This should be rather someone from Cirrus or their regular contact -
> patches@opensource.cirrus.com.

Alright I will do so.

For I2C and SPI description, is it required to add it only once? or just not required at all?

Kind Regards,

Saalim
