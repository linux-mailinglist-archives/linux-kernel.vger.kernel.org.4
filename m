Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F337F746AFE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGDHqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjGDHqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:46:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF9AE7D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:46:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so8183565e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688456778; x=1691048778;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7TDnTqy2juWXdJ8BfFpa3LvUwBo3k2Ws/LZ+pW/+VDQ=;
        b=AEDPUzFTIuc9GzhGsDSEOJzcMxX/P67pjKBF9g0976OZE9P0OoExonNNZ+uVK1ri5D
         pHMo6nN89MwiAqNc3p+5iso8gx9JaO+/38+dg7OqjTXr4gedc51ogiaA6aBIQiz9Nx7o
         nic7887lW1BalMg/rHgvTHfqeNk0mTyHZR0hPm/Km4NBbyW9OQ/hr5sV67qVkSaoWsM3
         X95FosxP2Ep/IXPgZRtRhCkzN7mp7yU93khHH5LgoAUnf1F4nzc5bbEhpeQ9hX+VqAfH
         9Zg53i0Ksou4sl56E3Y6Qgd60H3LNYzebb8dVCwOZtqa2+wc9mxUi/NY1PTdsLbDCvfp
         9DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688456778; x=1691048778;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TDnTqy2juWXdJ8BfFpa3LvUwBo3k2Ws/LZ+pW/+VDQ=;
        b=YnpQdcOrEXxqQzOTziso2OUgSLjfpeuP53Ewanko5Usr1iisTEYXrliuK+84ZZSFyP
         EWRrB94AGeNd+axn73GkptCWDA1D01CcI6F9JCRVGXZrvdRdJVW1pNnncQuH6GXlUlFg
         H6DxubNSTaGWJjeb/tXHMd5W/w+XY7IJiaa1ShSLyBwa0qulOl957pEQxNY6bA7jYHrk
         b7hpCvTOnniDVncUJ6KDSXLxYGkRAri3ICdQK/nqGjaHmV3ZN/iO18o9P632AWE+lRy+
         qRcVgFQSl0WjZMWCov5EZWdCgwggFxrJKViKTviWonLq97SThGNuz6573fvgqq1NNshk
         zlJw==
X-Gm-Message-State: ABy/qLbgrUc6mE7U3Vxi2We6gFb9bkIo0qWItEdw60OSWNc9KYVPJ5+l
        0xa+7kwbhoPRMGrdTjBQmVXAViIxh5Uk6d4eZlRmeCVj
X-Google-Smtp-Source: APBJJlFYQJfJ4JK+vhQV9FJfTZcfRwSwbfnvvmayCo+4o5rmAO+xjopKKsRp+ts5jfpQ3XteO2g5gfQqY8YYxft5wyI=
X-Received: by 2002:ac2:4f14:0:b0:4f8:442c:de25 with SMTP id
 k20-20020ac24f14000000b004f8442cde25mr10207105lfr.5.1688456777737; Tue, 04
 Jul 2023 00:46:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:1a47:b0:290:25e9:9dde with HTTP; Tue, 4 Jul 2023
 00:46:17 -0700 (PDT)
From:   Budi <budikusasi@gmail.com>
Date:   Tue, 4 Jul 2023 14:46:17 +0700
Message-ID: <CAH0GyZCNSif21TkX4Rt5HusgHhz8DsD2se4-UMa-KfiPc2Z9Mg@mail.gmail.com>
Subject: Anyone outright understand explain please,..
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone outright understand so to explain
What linux kernel #n (n is small number 1,2,3.. so on) acquired on
just compiled one in kernel package 7

such like
$ make
...
...
..arch/x86/boot/bzimage (#4)

$
