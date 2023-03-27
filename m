Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE046CB029
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC0Uzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0Uzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:55:45 -0400
Received: from qproxy2-pub.mail.unifiedlayer.com (qproxy2-pub.mail.unifiedlayer.com [69.89.16.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853C412F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:55:40 -0700 (PDT)
Received: from gproxy3-pub.mail.unifiedlayer.com (gproxy3-pub.mail.unifiedlayer.com [69.89.30.42])
        by qproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 2EE838047110
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:55:40 +0000 (UTC)
Received: from cmgw13.mail.unifiedlayer.com (unknown [10.0.90.128])
        by progateway5.mail.pro1.eigbox.com (Postfix) with ESMTP id 8D8C71004B4E5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:55:39 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id gtsRp19OaNX2agtsRpgOEw; Mon, 27 Mar 2023 20:55:39 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=NMAQR22g c=1 sm=1 tr=0 ts=642202cb
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=k__wU0fu6RkA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=Tjjzyx2epAFAt2jio4cA:9
 a=QEXdDO2ut3YA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IbG506QGMSuWow45FPISLdd8sXyJb3ywf8UWxzRGnFE=; b=ZvI7fNwj48QqgjBu3+KcmrG6BF
        tgDZdzWy8HGhiFPJlaxYYZ5anBOzE9HMQygbU83QT1e43jkBnPAD7HcogvKoc2+b53rEKwMvOreOU
        OOLbjebilMZkMlJvKdwRXQvHiHep3YFu1uvPsFY4o1i05lX2KZHDwU7sDB5DNuVCBe3p6zIeIuDCN
        k8dDbSIsj18Dt1YOip9Zg7REZLJwjWp6vq5FJLkvE+6tTn/2eO2PsBke64aLVx2axv/lo6R+WpIOg
        FnWJKmAxpxrKl2p2qnv0NEGxE+uM56OaQjbTe3rkobbGQMJMyasO+KjyONE+ed0DAP9xodyqodwG5
        iqi7+LYA==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:33266 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <re@w6rz.net>)
        id 1pgtsR-003YhS-1Z
        for linux-kernel@vger.kernel.org;
        Mon, 27 Mar 2023 14:55:39 -0600
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Ron Economos <re@w6rz.net>
Subject: Bug in recent changes to builddeb
Message-ID: <54a519ec-bfe5-60f3-fc43-707a11d38d2a@w6rz.net>
Date:   Mon, 27 Mar 2023 13:55:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.232.9
X-Source-L: No
X-Exim-ID: 1pgtsR-003YhS-1Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:33266
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like there's a bug in /scripts/package/builddeb. On lines 188, 197 
and 198, the variable $version is used. However, it's not defined 
(removed with recent changes).

This causes the headers to be put into /usr/src/linux-headers-. When the 
next version is attempted to be installed, the following error occurs.

$ sudo dpkg -i linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb
Selecting previously unselected package linux-headers-6.3.0-rc4.
(Reading database ... 376925 files and directories currently installed.)
Preparing to unpack linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb ...
Unpacking linux-headers-6.3.0-rc4 (6.3.0-rc4-2) ...
dpkg: error processing archive 
linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb (--install):
  trying to overwrite '/usr/src/linux-headers-/.config', which is also 
in package linux-headers-6.3.0-rc3 6.3.0-rc3-4
dpkg-deb: error: paste subprocess was killed by signal (Broken pipe)
Errors were encountered while processing:
  linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb

