Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACAC7485CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjGEOQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjGEOQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:16:34 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5924910D5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:16:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso10526414e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rockhopper.net; s=google; t=1688566590; x=1691158590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lY0aTKzrwAeYnsZsEjsLDORf/HPI8q3L+hAZKj5RLF8=;
        b=JsAhYeHZCInE9c8Xz6bGFGxifxENgIaoauIGlHnY7aCU6W42DF1LJx9nRRoam+BuAq
         n/Vp0g4Z8HmW9o3rLeoizm8EQ6wpDNGQEkCULaRhCcttEcDdT2J60thPMcxvrsuvXGfP
         ZoNHlPondLoouu7ZqHh670YTM7GlCBkl6wgWYQ58tK8aIB1OUzJsw2T5uReho10aCCBA
         eLrDsoFgGGaWds+ZgZ21bibnKH/M9k9SAav4wGa1/L2PxmDSkXNQn5bJ5dNoafEEzIKF
         TPdfwYvmOkgos2fSSHnG8y8B17e92AmW9wCc2/5EswYj/VPbR8TnxN8f89ZtFnVcZyGK
         rT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688566590; x=1691158590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY0aTKzrwAeYnsZsEjsLDORf/HPI8q3L+hAZKj5RLF8=;
        b=ZONkutKbzIgS7af+Fn/us0U/Pr6lnK5UvPHqd0M/SfjF5MF9g3Svyj2BlKPn/Mp/q5
         yKAe50FeL0GJI6E+an6Nbh+FlXUTzkrS4rcflQptW7zZjRPNUq0CALGyQW9Pm77btkrQ
         Vv6K+ucg4p6qJEYY9whVPiFZK/qXqFWEN8/4vQ7riy1XAYTzgEWFHWFC9pNKOhj7X9qK
         KeWTJrS83ShVAMwzNeidCQ5j52n/Irmvjsi+E0KMXyjP8oncXvQq6S1oxTISZys5XAxf
         QW6X5F4aTgeIp1Z/Ov9+1rJedxIO4T0Jl4regLYjYIcWWV1QiMKllyBgCYpH068R41lR
         Cf9w==
X-Gm-Message-State: ABy/qLYZiVZ04jCBvIMSLHADoxJ/TLJZ/7eZmyF9Q6i5tTW0mKhT53jO
        /IoorWHxq92W4J8ff/SIp6wq3hBTjIGqdIpg5bXD6Q==
X-Google-Smtp-Source: APBJJlHDMgbB1z0rKPmjtBMXbWzH7oBT33qRRysau6OnMkSuW585yUzLT0wTb4X4JK6lCiAfOUjo9SH0c63GUtxb91Y=
X-Received: by 2002:a05:6512:158b:b0:4f8:69f8:47a0 with SMTP id
 bp11-20020a056512158b00b004f869f847a0mr14346474lfb.29.1688566590436; Wed, 05
 Jul 2023 07:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHqEdrPuH4ayMiiq5FixaNjM=r44VJOw-v3iQ0mek55FTUWpsw@mail.gmail.com>
In-Reply-To: <CAHqEdrPuH4ayMiiq5FixaNjM=r44VJOw-v3iQ0mek55FTUWpsw@mail.gmail.com>
From:   Avram Lubkin <avram@rockhopper.net>
Date:   Wed, 5 Jul 2023 10:16:19 -0400
Message-ID: <CAHqEdrPD_EX=V0RnvvycN1MyXs0e+jkCcQ-nfHwOmyZR2LecfA@mail.gmail.com>
Subject: Re: Bug introduced in 724ba67 (ARM: dts: Move .dts files to vendor sub-directories)
To:     robh@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        liviu.dudau@arm.com, krzysztof.kozlowski+dt@linaro.org,
        lpieralisi@kernel.org, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending in plain text mode

SImple bug introduced in 724ba6751532055db75992fc6ae21c3e322e94a7.

The file
  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
was moved to
  arch/arm/boot/dts/arm/vexpress-v2m-rs1.dtsi

However,
  arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi
is a symlink and still points to the old location
  ../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi

My backup software is complaining, though I expect it will cause more
significant issues for others.

Apologies if someone already reported. I didn't see it when I searched.
