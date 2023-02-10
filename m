Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F67169258F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjBJSne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjBJSnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:43:31 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671434333;
        Fri, 10 Feb 2023 10:43:30 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AGgOYI020724;
        Fri, 10 Feb 2023 18:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=Bz3z3ISKM+2oA16AVmogsbzTonDoO83OvdEUQxDQniw=;
 b=m0QWOAKhLluxu3TPq2/1QbKMVT/chrdj7HxGL9kJVGYUD4glHyW7IbSBwz8K8N9CVJda
 n/SStk9WCffQhw24bT/Rrg7l9SqnJQGG8rOMAEJ9PxWri4AA/WoMkVRl0+EeY0ZUNlcv
 9PsboEVoYpfWIobl6Ym/b7FXgzy32YCQBru/xBmVk0hx4IhwSCFMxDGgTdq4g7z+KxaZ
 BKrF4bsmj4Nnlq9xGojqbniDggborwEO/UyrqK8dYt4m80taGC7H+gK0uXPew+RQve6K
 tflnNzG73mCREwfdgs4jhPNcSQTqxBhezcOLzmfUVGaEjA1hXPu0FIGSjief1IRGbbDY gA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3nnsp38xp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 18:43:13 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 82C4E805E59;
        Fri, 10 Feb 2023 18:43:12 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 898B5800258;
        Fri, 10 Feb 2023 18:43:11 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, corbet@lwn.net
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 0/2] Documentation/Watchdog/hpwdt
Date:   Fri, 10 Feb 2023 11:42:45 -0700
Message-Id: <20230210184247.221134-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yDET46Ld5TCvkT0ZShr4oSuCJOBJcrqq
X-Proofpoint-GUID: yDET46Ld5TCvkT0ZShr4oSuCJOBJcrqq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=714
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100157
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two small documentation fixes.

First: Fix reference to documentation that moved.
Second: Update List formatting.



Jerry Hoemann (2):
  Documentation/watchdog/hpwdt: Fix Reference
  Documentation/watchdog/hpwdt: Fix Format

 Documentation/watchdog/hpwdt.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.39.1

