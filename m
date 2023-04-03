Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98DF6D4CB1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjDCPyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjDCPyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:54:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072D235A4;
        Mon,  3 Apr 2023 08:53:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id kc4so28439729plb.10;
        Mon, 03 Apr 2023 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680537215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKTF0BmFIUa1JLXsVVVzhQGo7yEP1rvtiF0Y9gWPb8E=;
        b=L4VxjwPUo8WCU577qZCEQZ7pu6p8oNyJGyxXFOTQp5zmHJ40pDDjUEWoZvAFMWr3iX
         IXhsmBYVV4AdZ1cCtSkSWqJbLDs0AYskwC+ekhf21MUBcTOHuyPYrHcUXA2uXYDB5VLI
         trNo/Qfe4l+xU8uJgND9oZ3yEEMd2JspaHiZOhBGkcsi9V/KmMJ1CmtZMpBAIUkrq+iU
         BpkttpS2Olw6pBXHactkL2p/xlyok4F6o1qBgQSB1Ti89oxE60tG9NIKtO66/As7KtUU
         a/9x63J7LoTUlrOlRWk8UnWqN0ukskoztPWhRVb3NA+K1l5PphKlLWGGrGHrSrQIxCya
         UspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680537215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKTF0BmFIUa1JLXsVVVzhQGo7yEP1rvtiF0Y9gWPb8E=;
        b=J3P3qB7ohRLmawSncEfxzCwt8iCpdpRrgyQdLL1bYmo0sbu5UO/ICjES76z0zz/YV/
         wC0aEYaaBmFpbbBjkoGTRfPSf2tALkRDN89s2nDK66092n41LSTD7NBEYYw4kmG2AxIX
         VbL0EZbYXbVS0lKkLlRfZbcR6NKp/L5FQt5U/R48E7E0ChrxHsMLKFDVPQs/CaW/ESMS
         D8iW2jq02S9TCDNUJY/Jt8W5+puuhQJ85sfRj3NV0SE/6pcdWS4ng67cUL+RUM7k9jtF
         ZcYN+CCp4LfCOZyNHPvOhcLgIRgsOd0t8+PN/KGikC/1ApuW544OT9Yq/fKa/JEUn/fc
         ROdw==
X-Gm-Message-State: AAQBX9dsiAowxw26dnwoALquq2g+j8k9nMj66KYPShPGYhUBJK6QbuaL
        iwWVuJU8a/I/OFPLemHIX8E=
X-Google-Smtp-Source: AKy350YjCnyh/uk3o/BCfLEHu1k2UKAWFfWt3QXQRhRponKchCMwhVMVZSp02642w72S69hcs1tUig==
X-Received: by 2002:a17:903:24d:b0:19e:ecaf:c4b4 with SMTP id j13-20020a170903024d00b0019eecafc4b4mr44639769plh.4.1680537215464;
        Mon, 03 Apr 2023 08:53:35 -0700 (PDT)
Received: from pavilion.. ([2409:40f2:100f:dc7:d959:f34f:79da:6535])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6777186plb.64.2023.04.03.08.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:53:35 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, robh+dt@kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: wm8510: Convert to dtschema
Date:   Mon,  3 Apr 2023 21:23:25 +0530
Message-Id: <20230403155325.5797-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d6b4df41-02cb-b900-5e8b-8ad08d3d36f1@linaro.org>
References: <d6b4df41-02cb-b900-5e8b-8ad08d3d36f1@linaro.org>
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

Changes from V1 -> V2:
    > Added cirrus opensource as the maintainer
    > Added missing $ref to dai-common.yaml
    > Dropped I2C and SPI description
    > Added sound-dai-cells property
    > Added 'compatible' as the required property
    > additionalProperties: false -> unevaluatedProperties: false after adding $ref
    > Added SPI example

Kind Regards,

Saalim
