Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5E55F0438
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiI3FZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiI3FZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:25:35 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6143BC4F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:25:34 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28U5P3Hx019523
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:25:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28U5P3Hx019523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664515504;
        bh=/Jaf01SUWmz09yziakHV1BaZA/73tUwGVfiIXyG2bQM=;
        h=From:Date:Subject:To:Cc:From;
        b=01SNtTC5RtuaI42B60FfeyaZiJ1tUHPmOoYKJMTk6F9Kg/Gh6wpuuu4MUSrOMsJVx
         So5dGR/yWsK5NEC7/sNmn/Q/eoQz/28Ux/2ntWChe9Pmsik7sfX4mGifJ2FpBVNDt+
         NaHkZ1C1gRyhUZMWY+fTErWsSgUwbvITxWOTbdKbIs+oujgEIeqCq1yq9O+WxiqObm
         Ojn4OhMEW+Y+dJ0VUW1nTqLHgj81gtPgxxW8cHyijdSsDYEbjQgktZdBa2WB3sBZpO
         GdJqteCiGJH2Q3HKa6JrXWLwJEss5ralt9jUfkOkKeGQCjq/GPPQ0Bdg/3tWQv3K8s
         iOm5gq6JFsrBA==
X-Nifty-SrcIP: [209.85.160.45]
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-131ea99262dso1989505fac.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:25:04 -0700 (PDT)
X-Gm-Message-State: ACrzQf3MUSXY6CHFDOtw3X+9zhWGzOik+wrvNxYobY83z6Tmmmmpy+7t
        N9uJOg9y9Y8/lMqbomsvB4vEOlfTZcPK1DiCZGA=
X-Google-Smtp-Source: AMsMyM6GzfaMfYTPn/TtJalxn218i41Jux3R89zp2d50WCMKSM02Qc88KgYOSoAYOKqJMmUbuV9TpWcJGTjN/iusdQU=
X-Received: by 2002:a05:6870:6326:b0:131:9200:c99d with SMTP id
 s38-20020a056870632600b001319200c99dmr8998549oao.194.1664515503370; Thu, 29
 Sep 2022 22:25:03 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 30 Sep 2022 14:24:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNARcpThimq9Vgc3RXBm8jTN_9gv0HAV00nhLRuVU1HzaxQ@mail.gmail.com>
Message-ID: <CAK7LNARcpThimq9Vgc3RXBm8jTN_9gv0HAV00nhLRuVU1HzaxQ@mail.gmail.com>
Subject: 404 Not Found (/0day-ci/cross-package) for make.cross
To:     kernel test robot <lkp@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Intel 0day maintainers,


When make.cross tries to download toolchains,
the access to https://download.01.org/0day-ci/cross-package
results in "404 Not Found" error.

What has happened to the web site?



masahiro@zoe:~/ref/linux$ COMPILER=gcc-11 make.arm64  defconfig
Compiler will be installed in /home/masahiro/0day
cd: Access failed: 404 Not Found (/0day-ci/cross-package)
Cannot find aarch64-linux.* under
https://download.01.org/0day-ci/cross-package check
/tmp/0day-ci-crosstool-files
gcc crosstool install failed
Install gcc cross compiler failed
setup_crosstool failed




-- 
Best Regards
Masahiro Yamada
