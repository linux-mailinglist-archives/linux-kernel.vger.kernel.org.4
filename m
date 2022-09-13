Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4425B6EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiIMNz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiIMNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:55:27 -0400
X-Greylist: delayed 31443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Sep 2022 06:55:24 PDT
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20743F33A;
        Tue, 13 Sep 2022 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1663077320;
        bh=Du8wN4JKWt53EVdfv30oFoUsZKvKuMkH4lwXQ9KG1r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=g1ZyglXZGPpH/GmkZGEz0SDr3Yhe/2jVIs3fNmZXzXibYWA9IsEaUpqib4+IFiQbF
         lvKt+xH2iVLFXW/Qhsrc6n295//nSnN22VL62zYaqYlQ198obXj69js9nNKZKTtvSb
         ASv9OFoXkly5nCDW/v47CM/22/UYX1jmXpvI8WjQ=
Received: from localhost.localdomain ([111.199.187.40])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id DCE86EA6; Tue, 13 Sep 2022 21:55:14 +0800
X-QQ-mid: xmsmtpt1663077314tn9ukr4ek
Message-ID: <tencent_43596D97142AB4AFFDA36A8813061442FF08@qq.com>
X-QQ-XMAILINFO: MYcyYH/A/+tCKcVtE3+KkR3m4ZW8CXQOS+du6L93aNvz9PpBGvhHcn6loEKyiK
         pnmTjVf1ImvfC7VPnwiNdfRB5E4r2DcH23tza9ccYiI19n3bK2B/5hG00tbftiSVqyokRmBPm/5y
         etVN3fiqE2A78YELDtObOdbPn5wJ9Q9fylg2gqfGTrVvZ3hsEUwK0KRTjcvp6V54hO1N9ryISwAA
         sRv5sSL/K6BdDJWVfU1mk60HxKEDlVKYBuX33QxyOy6T8zZG9ceaT/C5omwvzOqAFPMxI5nRRIZ9
         yg73d85KhfJEiOHWCyZBppFwSXmqLxeO9/cxUti7DE9naebiNokyOoS+C2N6gPLYc78PV4m2apJg
         XaGb76nZiiEUXY+8Jm3CVIpi7ZhVNDU7mAXrr236d5d9h3mNIlZYGGNx6S00rjmmUUo+nvhi2tnw
         02403xyhBFLEwv4tf2853ZUvBk57CQu4kUAeDbmGUnNemDmChdHSXelSdjEq0SxXDUOEc3cSa1iG
         f+z7hjCKbNhoVyLg+OJ0obNRwUOXP16dxZAauyHZfQkASbWlGj/yCk+vrkRom/mgTqU56w3CyCHn
         O1ND9n0DNbdcXnxFp45MXsj258g9vlm/Zhj30jKD7H9l+Jp+SFwgeGwbIhwS+2jqRviY1sFsu+z7
         NVUZIv7P0IB7n1yHvidb5ojItSdnGAKgMnPya4AFxpSUfMFhIy4mF6WehL53HKrmbeIp2u6fJwN9
         MPtY3slp4JxlaZP408XdOQcSNGW/ODbfqTLb5+WKh/CvSlvFnZTxdttef+MJ0YWipG8ObcOv81m9
         nnfQ6audrRsjDamUJUtKILWqbeJGA4pnC9z5k51f3oK6huWv7stlOuBowphH9o1/pLIclaHVsaGc
         c+GPxMSnFjm+X4hPqr4FS1L/1yduxNgD5RYP7euAdofjTQiOuoeieQK0Lq1BroqPctKW4mbuvmyM
         Q3UdKRigF6kPSCyxbh6apGzGySm/yEYizJ3Lx+2mYnZF2krsp7PfCP7ErtVOnGPeBfsHC6fLo=
From:   Rong Tao <rtoax@foxmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     corbet@lwn.net, erik@kryo.se, jkosina@suse.cz,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@leemhuis.info, lkp@intel.com,
        ojeda@kernel.org, rdunlap@infradead.org, rtoax@foxmail.com,
        tglx@linutronix.de, Rong Tao <rongtao@cestc.cn>
Subject: lkp report WARNING: Title underline too short.
Date:   Tue, 13 Sep 2022 21:55:13 +0800
X-OQ-MSGID: <20220913135513.16735-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cc102d14-77a8-f97d-60c1-f0918656905f@linaro.org>
References: <cc102d14-77a8-f97d-60c1-f0918656905f@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Hi, thanks for your reply!

https://lore.kernel.org/lkml/202209100436.Ud19XNGq-lkp@intel.com/

The doc submitting-patches.rst has a WARNING 'Title underline too short'

before:

 Backtraces in commit messages
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

after fix the warning:

 Backtraces in commit messages
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

add a '^' in the end.

