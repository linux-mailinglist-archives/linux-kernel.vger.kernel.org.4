Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083E16F6741
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjEDI0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjEDIZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:25:21 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005846185
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:18:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683188332; x=1683195532; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=ms3njcBQrrmRVxxbQssJjnY8BrYOrndinPX9QZIyRxU=;
 b=kVI/kK/cfVePXyfKN8F3nT/QhFQZMufJcfyrNWHv4dgN0yLGa2fvNLrcEkiFiXbwMG9d9h1uNeU18yZZGijprmaHPepI45RgPYOpXhSV2C/L9CVKf8Bdl4iXk34i4dALQH0Sifx1pXWfokmULXXehdpWtSEmpWNmd97DN7nkJw5ploN0BS0Ex0lvy0ektW98S0mmGJc90/3T4zbdjV60u0WovGZpWjPoP/OUcD1SZAop6a/BuSw7W5D17JS4cBwmc0jctnc8/Odfbj4vW3Dtua9LsMUt0ZXV91DJEdne+x6UAPycsd3Me2omdU+B37YTCD5V71pUt1DzMxS31TGYsQ==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by f7d08f3fa3fc with SMTP id
 6453659de31b292e1ff52a9c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 May 2023 07:58:21 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 00/11] hwmon: Modernize documentation
Date:   Thu,  4 May 2023 00:57:41 -0700
Message-Id: <20230504075752.1320967-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help summon the beautifully documented kernel of the future
promised by the move to ReST, this series revises the hwmon subsystem
documentation to make it more comprehensive and internally consistent.
The latter goal also requires a few API and ABI additions that should
have been in tree but weren't.

James Seo (11):
  Documentation/hwmon: Move misplaced entry in hwmon docs index
  hwmon: (core) Rename last parameter of devm_hwmon_register_with_info()
  hwmon: (core) Revise kerneldoc comments
  Documentation/hwmon: Revise hwmon kernel API reference
  Documentation/hwmon: Revise PMBus core documentation
  Documentation/hwmon: Revise patch submission checklist
  Documentation/hwmon: Revise sysfs interface specification
  Documentation/hwmon: Revise userspace tools documentation
  ABI: sysfs-class-hwmon: Revise hwmon ABI documentation
  hwmon: (core) Add missing beep-related standard attributes
  ABI: sysfs-class-hwmon: Add missing hwmon standard attributes

 Documentation/ABI/testing/sysfs-class-hwmon | 901 +++++++++++++-----
 Documentation/hwmon/hwmon-kernel-api.rst    | 740 ++++++++-------
 Documentation/hwmon/index.rst               |   2 +-
 Documentation/hwmon/pmbus-core.rst          | 348 ++++---
 Documentation/hwmon/submitting-patches.rst  | 110 +--
 Documentation/hwmon/sysfs-interface.rst     | 984 +++++++++-----------
 Documentation/hwmon/userspace-tools.rst     | 129 ++-
 drivers/hwmon/hwmon.c                       | 169 ++--
 include/linux/hwmon-sysfs.h                 |  19 +-
 include/linux/hwmon.h                       |  90 +-
 10 files changed, 2037 insertions(+), 1455 deletions(-)


base-commit: 1a5304fecee523060f26e2778d9d8e33c0562df3
-- 
2.34.1

