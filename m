Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ECE6FCD10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjEIR5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEIR5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:57:32 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5A40F4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:57:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683655050; x=1683662250; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=H0s1EjZuxhXngjZYqwpGITBPMAphxWLlgrAxCrBbyGo=;
 b=JJpzwpotyqD7HAot+RB44YbnoPidp4bgCUdzqMT+O4mf5OGzmE6L5eAUSAuckB40VUHwWKXp2Tc31aTQT7EOhkTSLgil4P0IlaIB3Db06Hq/QstEB6MMLbdTOKQf+Q3EvgW1iOaqlsM9KqHKBuQaClFbASUD/RkvFWfkTXarUF9EhnMZWM4RblErpTwVDVfW8/+GRfl9nfHWPUx3SYJ4Rr2skw3nZrhPkPuH8pUJcuLp22s6YzOIHrgu8et6Nn99SAVhxWIgeCCVem2Hv0NBc8YaVUUu1R3g+YrOps+EavPAywiBtHd4Xbxd4d0rEJjwTa/N3/4SBc060OYLOWqg8w==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 6da7de3861f4 with SMTP id
 645a898a2eb1ecdcf6398bdb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 May 2023 17:57:30 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     James Seo <james@equiv.tech>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Generate documentation for error pointer functions
Date:   Tue,  9 May 2023 10:55:41 -0700
Message-Id: <20230509175543.2065835-1-james@equiv.tech>
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

The error pointer functions are collectively mentioned hundreds of times
in existing documentation (e.g. "Return: an ERR_PTR() on failure.",
"If IS_ERR() is true, the function failed and PTR_ERR() gives you the
error code.")

This series adds kerneldocs for them and brings them into the docs build,
immediately turning most such mentions into automatic cross-references.

James Seo (3):
  Documentation: conf.py: Add __force to c_id_attributes
  err.h: Add missing kerneldocs for error pointer functions
  Documentation: core-api: Add error pointer functions to kernel-api

 Documentation/conf.py                 |  1 +
 Documentation/core-api/kernel-api.rst |  6 ++++
 include/linux/err.h                   | 48 +++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

-- 
2.34.1

