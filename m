Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB16F2AA3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjD3UcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjD3UcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 16:32:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1966AE76;
        Sun, 30 Apr 2023 13:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682886717; i=w_armin@gmx.de;
        bh=1iVtXdw2HihhlcV6imnqHABioEJXOGklEJ+NVAHrz0k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NT5mEF2NNSh5y6UPC4T+ULzfufgyhcHwYM092pNQ/6ahrlmSfpm8sUBOvu7q4tOXd
         0zHzaeu2CuFvSP4VT/BwpdTLpdcdxX/nhWoeOTb7rJJTZ0K24CnYzm0od8xW7FRkfF
         UNsGV3OBnk6t9Ot4drNNhUrjlyx6ALYRN/Sqmlu72aIfrJ3yJyd2mlbYDRqNMQ08BT
         UHkySnW4tyez3GlbgUgHLCqx8G1DizeDMz4LwL1/GpvwckvRDJzHDmSnTmV3P5BYOy
         DOo8SBfaFQMBPdIVbeMHAaVvZPH00A/7QAHxe5y/S4cLRREWd160gReQK0pejJ+Xj+
         Z5YHKRM1v+1IA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MBDnI-1pyDdy3jdW-00CkSa; Sun, 30 Apr 2023 22:31:57 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] platform/x86: Allow retrieving the number of WMI object instances
Date:   Sun, 30 Apr 2023 22:31:51 +0200
Message-Id: <20230430203153.5587-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eRB9SbYAP0wd8FO6N+p+W1r2ZcZ4JPe/LaFtJzAwQT9lk+52BLx
 ezBvqm97qHlaYrZYygJEkxFvrxkdHKJc4wDR1i3Wsg9s4TqDguvGHrXC0thnafJX+EArGjR
 wsegqIxMj51JcQO78s36v0J3ruglE3TEGKr+Llbr7cc04sC5hNRTpAxcSlmZWiZ47KQKklw
 EJzJrbE4hktdioiXHnDKg==
UI-OutboundReport: notjunk:1;M01:P0:OWnQfJaufvI=;x98zCkXRJnkV2arj2waP2wFW6K3
 XkC29Rr2/pUUWK3yPhx49gxmAw3Y4xRLhogsP2ZoKfUcqHLhp6UHioRsyS4jjT9F0qzgSxbeo
 brP2Su/08XbO5Sv07gMIYWBNEP0SvQ4Im0ZoStcSUZe1HEsx+6WoJTSXjpHP0yNO1naeTOJhp
 WacIOwkfKT6p1Wa4rNUDP6FC2M8/lNdg8Va3+vS+CpXdVu3E8xkyL8uH5XBZWjq4OHy2H5zNK
 WGHAuleYuR+YdBtkRWdoKt+G8V6zxk+o8/VBvOA3Zh/jqvndo46ta4lQwHDIggLOtmGmGLLap
 QejpBQZFSfVk4jalJXrM5FtTmkAykHzEt1XKqVwAnd7zuCT9uOwGk+es6hCDwFop8Il8ME9Rd
 6rh1ldPB6pJcESeFNhko/Yj/7+ta2RrXALVlclsuILpMz/aG/bZH1d6M67gBFMbusdTxzmf0e
 hqytjPjFrg/kUxBKDviL07wMiIYmQ/3TPHtDMLhVS+Crx8NIoGREm/4wnH+2Q4OVW6xxVz5ZR
 7zt/LF3uDaUh9XgRUzn8g6gT6ikRNcMRr0AnMMJOQjB5w29fSZJcbPX722NAqjh+0pBNES16d
 USWs+uWA9kvTdL70ba61xQ0do3mP8RSL13kYjEaFHBo5VYDoJI81w7ECdKcCOaNcYfYacwf8A
 7PVpIsa/LobrE4U8zEHHK9LAege2j3pPUKb+EsYwJq6ivXNAVI07usJlUipb09SHmNuMjxM9m
 2WzeqAf4Iyen5/L3YWA6mZ6CGuGzaPAazi8JF9zdiUUDW1f/Zvc/ygoy54OHWfq/WgcP/Dx5c
 NAXq1n12Ftyjxlh9/BzhX/QVWrsSUrTFVZgq1mpCFrmNd6yX64GnlcBlIQge7ri9qAKfbECDQ
 JNZYFp1E6iQnIfenzGzvX3BzI01y/bON/hOYyw/2BWvKcxxKsN0iE6lV3VDg1l3+eEgLnWPkR
 BGrpQA/yDCn0GcUDDclUUlgrErg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series allows WMI drivers to retrieve the number of
WMI object instances. This functionality benefits several current
and upcoming WMI drivers, the dell-wmi-sysman driver is converted
to use this new API as an example.

The changes are compile-tested only, the change to the dell-wmi-sysman
driver also needs to be tested on real hardware.

Changes since RFC v2:
- modify wmi_instance_count() to return an integer

Armin Wolf (2):
  platform/x86: wmi: Allow retrieving the number of WMI object instances
  platform/x86: dell-sysman: Improve instance detection

 .../x86/dell/dell-wmi-sysman/sysman.c         | 13 +++---
 drivers/platform/x86/wmi.c                    | 41 +++++++++++++++++++
 include/linux/acpi.h                          |  2 +
 include/linux/wmi.h                           |  2 +
 4 files changed, 50 insertions(+), 8 deletions(-)

=2D-
2.30.2

