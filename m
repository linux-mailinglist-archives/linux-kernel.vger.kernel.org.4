Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8986F45E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjEBOQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjEBOQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:16:22 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB54212A;
        Tue,  2 May 2023 07:16:05 -0700 (PDT)
Received: from user-virtual-machine.. ([10.12.182.5])
        (user=jinhongzhu@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 342EF4Mo011011-342EF4Mp011011
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 May 2023 22:15:08 +0800
From:   Jinhong Zhu <jinhongzhu@hust.edu.cn>
To:     jinhongzhu@hust.edu.cn
Cc:     GR-QLogic-Storage-Upstream@marvell.com, error27@gmail.com,
        jejb@linux.ibm.com, jhasan@marvell.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, skashyap@marvell.com
Subject: Re: [PATCH] qedf: Fix NULL dereference in error handling
Date:   Tue,  2 May 2023 22:15:04 +0800
Message-Id: <20230502141504.2964-1-jinhongzhu@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417135518.184595-1-jinhongzhu@hust.edu.cn>
References: <20230417135518.184595-1-jinhongzhu@hust.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: jinhongzhu@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not apply this.

regards,
jinhong zhu
