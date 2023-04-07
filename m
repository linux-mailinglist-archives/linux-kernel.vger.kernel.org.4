Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECE56DB0F9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDGQy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDGQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:54:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8B96592;
        Fri,  7 Apr 2023 09:54:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g19so42041146lfr.9;
        Fri, 07 Apr 2023 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680886461; x=1683478461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDrr7csLtUd4NajaBFPxSIyzSskY00AAqNC75wqrt68=;
        b=T+YXdLdoliWNHBGwLVBy1Hcy6y1UYJp4kCwK+ymEOEVdd017W2faGw4MjV8daDIqXc
         06jFsq6Rj2IAaj5xUgF2jSdcvpCJSUjm+ODzgz1CbhQnibfb6oMM41aUugdept9Y1XBp
         vzJJJRuFolDg4wN/DVR/Cn71mjs2LCqxtrpxm5FKr84ntIJhcW/Tp7Dqy/xU01DsfThu
         Qodh8I59SMuN/eEBxi0zn6ls2C7/llLi0js/KtsOYqajhUU2hzB320Vy/f9MkqD9bubX
         OXsz6Aukw2K2xIf4L4CC7A7gmkb3yV4980oaVIThu45lEZsh/9WVZH3GCBBlpT9Cw0nx
         yPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680886461; x=1683478461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDrr7csLtUd4NajaBFPxSIyzSskY00AAqNC75wqrt68=;
        b=l5UKQXZNMJyKdWNyF/Nq9O84RyEmE9qfMSmVfJiFEM/nEzl5pHUPyB8JKoo8gFUs7S
         ap65Cqts28QTVteM1jnk5GWhn/ZaKiA+2dWvbmayNXsDXNJd2z7BngcL5HWZJwOwJzvO
         LDMuwCmzz4g6G/B82iS+w1VYZit3aIUVSh1X0WwE4fV/ko5Hf9UvwN4Nb4ZRJnu2UduR
         lz33gIAtqlpdWB9GDboIkws7EYmi76e5pFJcPell9BSMhyGUSlUEOpFtf13AQ6ubRUzO
         5soN9LGQ8hIzZWZMdrmEUL7N4icagZiska1wAcXZc8hLDmHbLNIlbNs4K+70ODdmGEhB
         ElIQ==
X-Gm-Message-State: AAQBX9cK9v1D+AMiOqzw2Dd/gT4eUqsUbrPmO5lotJ5APktVreQhNvFp
        Xh+yZdYy9e0w7e6P7cXLX7NbWfJGGI+FqQ==
X-Google-Smtp-Source: AKy350Y9rMwZnYR8U22jM71G/u1U7HyEZ5v8JecZM6dRDSdZDU00PtjJPlfbk7p/Ph5u4lrd25AYpA==
X-Received: by 2002:ac2:47ec:0:b0:4e0:a426:6ddc with SMTP id b12-20020ac247ec000000b004e0a4266ddcmr896389lfp.0.1680886460721;
        Fri, 07 Apr 2023 09:54:20 -0700 (PDT)
Received: from localhost.localdomain (byy157.neoplus.adsl.tpnet.pl. [83.30.44.157])
        by smtp.gmail.com with ESMTPSA id c3-20020ac25303000000b004db297957e8sm781712lfh.305.2023.04.07.09.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:54:20 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] MSM8953 remoteprocs dt bringup
Date:   Fri,  7 Apr 2023 18:53:41 +0200
Message-Id: <20230407165345.42800-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduce nodes required for bringing remoteproc cores.

Adam Skladowski (3):
  arm64: dts: MSM8953: Add wcnss nodes
  arm64: dts: MSM8953: Add mpss nodes
  arm64: dts: MSM8953: Add lpass nodes

 arch/arm64/boot/dts/qcom/msm8953.dtsi | 358 ++++++++++++++++++++++++++
 1 file changed, 358 insertions(+)

-- 
2.25.1

