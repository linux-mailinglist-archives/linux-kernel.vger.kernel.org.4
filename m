Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5496DB024
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbjDGQFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjDGQFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:05:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A22DB456;
        Fri,  7 Apr 2023 09:05:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id 11so9330257ejw.0;
        Fri, 07 Apr 2023 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680883535; x=1683475535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5SLlhqnz2wbU4JFjRDFJO2qMNf0STn6v2vDBnfSBuDg=;
        b=B+EPNBVin/bTm1goLeAt+uh1jkhPs82zpJOoJNv6a3taN6lDHM6tFOlrVJdaVp1Lj/
         nO/a1eV/u4/P/C3fMhIuqRzYlKaJQuVEtD1kVkEl27gzqnVrufnQdI53Vc5nrVrfg1gv
         Dgnxn8QSawkhNI1V7wYL5gNOUpxdt7+DDhylGKjr3QUpXYehxVKUy6namztwGqpl6BHH
         Y26AEkdDQj89ui3HbJzBuH647JM1+M6XMIGHfr9Iqxx9daDKwetHaBqFhzbhuti4b8l7
         ZSTxTwNt/SF1HBH6BKqO/84uZ6JU4jliJUOM4OQ12NjSz3N7OsXI8XmsB59bZRSEtAg8
         5gOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680883535; x=1683475535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SLlhqnz2wbU4JFjRDFJO2qMNf0STn6v2vDBnfSBuDg=;
        b=egggmMqR/z/L13pnEiAaojzPsQho0oWmnTNMqoDTRKVX1TQXzdB5dwvnckIB94CD+6
         vFCtvLN0bWxEZ7nTGLMpsUPL5NR6eULHOVFnl78Y/S9J/gTEy6Je+QQntApc+yev212O
         0WR64BE0zOXeTw0ecGRI3ic4GB6WzacrXvi8YGMyCl7wfEdZxX+nThiEHzoah9UfF8RX
         2xJBhS9fg9Eix3yw1T8k1GjQG9AnH9e6deIT+GBIpYK+oU/BxLM/JX1NyZFfpKtRf8lV
         iHyLw+LU+bqEVHRB4MXQi46bbjrF/CMz4u3POZ638AfnLTsgAz3glHvZxo0Li5tipFru
         owig==
X-Gm-Message-State: AAQBX9dEYieW5qKdV5wpd5hs2vpPgP07zd5AMqqXD2zhRsaKP6zCbAcL
        sTmwkjkLmff6Cy/u9ls926M=
X-Google-Smtp-Source: AKy350bxokhQsVv1fvyXloxSuJuTzfbuuAAJEa3N7DCH6nKt5Ap5UZ6p/yJnJrTvQM2LcredvcDXSA==
X-Received: by 2002:a17:906:2bd1:b0:920:3263:d643 with SMTP id n17-20020a1709062bd100b009203263d643mr2530683ejg.72.1680883534699;
        Fri, 07 Apr 2023 09:05:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.79])
        by smtp.gmail.com with ESMTPSA id lf11-20020a170907174b00b0092b546b57casm2147585ejc.195.2023.04.07.09.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:05:34 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add power supply for INA2XX
Date:   Fri,  7 Apr 2023 19:05:06 +0300
Message-Id: <20230407160508.20479-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI ina2xx hwmon has vs power supply, add one for correct work.

Svyatoslav Ryhel (2):
  dt-bindings: hwmon: ina2xx: add supply property
  hwmon: ina2xx: add optional regulator support

 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 5 +++++
 drivers/hwmon/ina2xx.c                                 | 4 ++++
 2 files changed, 9 insertions(+)

-- 
2.37.2

