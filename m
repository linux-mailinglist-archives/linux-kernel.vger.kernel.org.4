Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5045FB904
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJKRO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJKROW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:14:22 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9253BAA350
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:14:20 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d142so5404539iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pDLbMMyVql0t8YQHrpoFb/mrSX/wy9E8ZPnLS8f6/sg=;
        b=QXHxzennHT0jWhFoHwN6F4UG3DVi7ZCQCmnNa4hVa1YpzqTEJ2H2thcKZZtDII+5Ri
         Ln3OIwIuzi7P85Z7IaTZwJXP6TiBkUHXzZ+er3QEjKMDrkQdf9n/lAbe7xuOVqvm4bZL
         IxZZXf4C3hBQzqz76jjrQR75Ds7/2VEhAhUVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDLbMMyVql0t8YQHrpoFb/mrSX/wy9E8ZPnLS8f6/sg=;
        b=1qf7ThbBDKPDcd60VeszJJ8HFokYt7dXrwUDzi+zqMc5meOeLBDoHnKe4zXs2cULS/
         wn5voqUC+D+uHblMdEZ1Nqot8CcXksQDkzywVgJD9a00kD5eyYWbh7ayEHMMVBhOpccr
         GYFvW8exgieyDm0KCKHu8qgqkjA9dsea2r/8lgzrgNvxrk1XAMnOev4tuXe+tBF/FwzT
         pnoArE/sV4xjMIHs6wZDBMsZbmJFQD0tCz3TeTKp08YQpLULSNdiFgTByoRPimAidaA/
         rs0e3zwvlIGKq0mjU0aHPNUmbeXOWr9XAJ7vvOyIgMs8Xagssb+bUIe9l+dYzf42/IRj
         wh0A==
X-Gm-Message-State: ACrzQf08+uUqrnpye87NkdrLo2TOtyX2lclFHFg4Bk8mWbUQoT9XqwSB
        kr3BizfZMP8Vh5YIebhVTIHGmw==
X-Google-Smtp-Source: AMsMyM4/OpJoLj6r1F+/wC8QgtHX8DjKlVz9AT1JvWxmVE0aHwN3eNgc+aaDUSRj2vDk34JD7p5pdQ==
X-Received: by 2002:a05:6638:4782:b0:363:c5a0:2aec with SMTP id cq2-20020a056638478200b00363c5a02aecmr4483441jab.242.1665508459629;
        Tue, 11 Oct 2022 10:14:19 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g18-20020a056e02131200b002eb3b43cd63sm5088215ilr.18.2022.10.11.10.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:14:19 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     gregkh@linuxfoundation.org, corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>, conduct@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jlee@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH] docs: update mediator contact information in CoC doc
Date:   Tue, 11 Oct 2022 11:14:17 -0600
Message-Id: <20221011171417.34286-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update mediator contact information in CoC interpretation document.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/process/code-of-conduct-interpretation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
index 4f8a06b00f60..43da2cc2e3b9 100644
--- a/Documentation/process/code-of-conduct-interpretation.rst
+++ b/Documentation/process/code-of-conduct-interpretation.rst
@@ -51,7 +51,7 @@ the Technical Advisory Board (TAB) or other maintainers if you're
 uncertain how to handle situations that come up.  It will not be
 considered a violation report unless you want it to be.  If you are
 uncertain about approaching the TAB or any other maintainers, please
-reach out to our conflict mediator, Joanna Lee <joanna.lee@gesmer.com>.
+reach out to our conflict mediator, Joanna Lee <jlee@linuxfoundation.org>.
 
 In the end, "be kind to each other" is really what the end goal is for
 everybody.  We know everyone is human and we all fail at times, but the
-- 
2.34.1

