Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558E6D58E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjDDGqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDDGqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:46:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B541BD2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:46:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ek18so126402570edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 23:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680590800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4wpR6cNIQTvfB1y29ZH5QI3kXm7zB6AepahRK+63rE=;
        b=khwNPCkNrTb762NkLnpHGVzJhZ5WIWF+EOnsbBkt0KrE4zdGipdWW2N11ieQlQbMSe
         E2W9Ss8tXC6cpzLZZT0u6oO7pF8kWWcAOgU9pHx8QdnCFcof3rNRbF9OptxFHfe5NN4l
         Z/YvIroVraQD+XGuOG/Ct5g7XLLPBygDey3lq+gsT99ReTJVW+G/dewsL9He7pPCUjQG
         k0E9K5xkRX1YqY7QAq9sjUy7WZuGGb1KhZgAexgmrLB/4vlgEuE0+z/ibwQ7LHR0dVek
         2Yln6f2ySUBep5iWqugj8zhYt4j2RuDUiAgBPpqg/EP/i+Mla5pPm0Rsmk3Ek0oEOUH9
         IbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680590800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4wpR6cNIQTvfB1y29ZH5QI3kXm7zB6AepahRK+63rE=;
        b=sEOtn6QRzcjj0MOzG46gWNagYAjj1LsbxdTMiYpmt3gjjyOfHMJRutr1dEWF+mYrDk
         CP4oSD0Ko9HkvZjT7/6kV0ThBM0KnXxXzwAit9LwhViw5hNvYIeNoAZDPsXGQeFfC86V
         ALYpkTqQXbAFLN5gpqaYKCVBbiHxOal0nuMC4q4fJUmsIUegVHUJGp9GtqjqJ2GsuFoG
         SJlwaHaICH16/hgCdb7DTgE6/9W6C+TfjNmzjuZ3Tumta9w3JIWzHf9EROjehhS4xOr4
         e3J6nbFJig8sdwnwAdKVKRldNHv4LWmkFlwoRU/bcuihwhbLgg6fk9a4OTkoD97gW3ue
         JBKA==
X-Gm-Message-State: AAQBX9dtQ3wqQuLGJPe2yAYKfRxjseIvEROHmYF8czeJ48s1f9mbZAvA
        fZ3LNDDfnZejp8GVYvHu0AJC8g==
X-Google-Smtp-Source: AKy350Y+t97vUdhS2WCc0Ni0IdloS9ZcFUGjiehqd+Cpuheu/4+0knXZYh9CGX1+xLnOu+l5/Bf2DQ==
X-Received: by 2002:a17:906:235b:b0:932:c1e2:9983 with SMTP id m27-20020a170906235b00b00932c1e29983mr1420766eja.15.1680590800622;
        Mon, 03 Apr 2023 23:46:40 -0700 (PDT)
Received: from 1.. ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id h12-20020a1709063c0c00b00947eafc76fbsm4488311ejg.144.2023.04.03.23.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 23:46:40 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] mtd: spi-nor: Address mode discovery (BFPT method & current address mode)
Date:   Tue,  4 Apr 2023 09:46:34 +0300
Message-Id: <168059071209.13361.9220222408280662768.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
References: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=OcC9/K8lIgvhLa3FaB7YCnUSc/5yNfT0lL/dHR4H3l8=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkK8fIasVkDyCV8ikOl65YC4X+oI59U43+u/+vC xWiYTQ2rYeJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZCvHyAAKCRBLVU9HpY0U 6Ut/B/9VlseaqQ12Q5Jfmuz95bqFwVFevcGGF6fCpq067twYUPxyOj92IXqZgxpGe2LQPgXEuJx phpQpArsUWCE5hB6FslxatZIwB6N5Ju4+03RlrEAuBLp44iObzLFJlBsy7P4g99L2nhR3jOdwMV MPbtcccGfS20MiMFYZMfjwxRTIaWHK+TQhnzgHA48CmaNl6o6NKelGTxmZBx9ymnvH3vjBdTm0A ne3LGLVzT9vqbtMxzJT4GxHl0IEcGvoc0Mjihev8yw/Kc3QzG7lxEOs2TjnIdlha03+lqFsaN14 30CDzeuDhYDAPEs7R2TxFjbh7ac9b86qrzowOKlTKw61oP8N
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 07:45:56 +0000, Tudor Ambarus wrote:
> This is a new version of the following patch sets:
> https://lore.kernel.org/linux-mtd/20220411125346.118274-1-tudor.ambarus@microchip.com/
> https://lore.kernel.org/linux-mtd/20230315034004.5535-1-Takahiro.Kuwano@infineon.com/
> 
> Changes in v5:
> - squash 6/11 and 7/11 to have a single point of failure in case
>   regressions are determnined by bisecting. Update commit message.
> - get rif of the now empty winbond_nor_default_init()
> - s/sfdp_bits_set/SFDP_MASK_CHECK
> - set micron-st's static spi_nor_set_4byte_addr_mode_wren_en4b_ex4 only
>   when the 4byte addr mode method is not determined at BFPT parsing time
> - reverse xmas tree for local variables in
>   cypress_nor_set_addr_mode_nbytes.
> 
> [...]

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[01/10] mtd: spi-nor: core: Move generic method to core - micron_st_nor_set_4byte_addr_mode
        https://git.kernel.org/mtd/c/076aa4eac8b3
[02/10] mtd: spi-nor: core: Update name and description of micron_st_nor_set_4byte_addr_mode
        https://git.kernel.org/mtd/c/288df4378319
[03/10] mtd: spi-nor: core: Update name and description of spansion_set_4byte_addr_mode
        https://git.kernel.org/mtd/c/f1f1976224f3
[04/10] mtd: spi-nor: core: Update name and description of spi_nor_set_4byte_addr_mode
        https://git.kernel.org/mtd/c/d75c22f376f6
[05/10] mtd: spi-nor: core: Make spi_nor_set_4byte_addr_mode_brwr public
        https://git.kernel.org/mtd/c/3a4d5f4af9e6
[06/10] mtd: spi-nor: Set the 4-Byte Address Mode method based on SFDP data
        https://git.kernel.org/mtd/c/4e53ab0c292d
[07/10] mtd: spi-nor: Stop exporting spi_nor_restore()
        https://git.kernel.org/mtd/c/7fe1b00d92ea
[08/10] mtd: spi-nor: core: Update flash's current address mode when changing address mode
        https://git.kernel.org/mtd/c/37513c56139b
[09/10] mtd: spi-nor: core: Introduce spi_nor_set_4byte_addr_mode()
        https://git.kernel.org/mtd/c/b6094ac83dd4
[10/10] mtd: spi-nor: spansion: Determine current address mode
        https://git.kernel.org/mtd/c/c87c9b11c53c

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
