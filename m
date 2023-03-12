Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34E6B65ED
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 13:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCLMQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 08:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCLMQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 08:16:31 -0400
X-Greylist: delayed 1503 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Mar 2023 05:16:30 PDT
Received: from connie.slackware.com (connie.slackware.com [64.57.102.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3032C39BB9;
        Sun, 12 Mar 2023 05:16:30 -0700 (PDT)
Received: from amaterasu.liwjatan.org (connie.slackware.com [64.57.102.36])
        by connie.slackware.com (8.14.3/8.14.3) with ESMTP id 32CBnqWY008298;
        Sun, 12 Mar 2023 04:49:53 -0700
From:   Heinz Wiesinger <pprkut@slackware.com>
To:     quic_schowdhu@quicinc.com
Cc:     andersson@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, quic_rjendra@quicinc.com,
        quic_saipraka@quicinc.com, quic_sibis@quicinc.com
Subject: Re: [PATCH V1] bootconfig: Increase max nodes of bootconfig from 1024 to 8192
 for DCC support
Date:   Sun, 12 Mar 2023 12:49:44 +0100
Message-ID: <2463802.XAFRqVoOGU@amaterasu.liwjatan.org>
In-Reply-To: <1674536682-18404-1-git-send-email-quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3495801.dWV9SEqChM";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3495801.dWV9SEqChM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Heinz Wiesinger <pprkut@slackware.com>
To: quic_schowdhu@quicinc.com
Date: Sun, 12 Mar 2023 12:49:44 +0100
Message-ID: <2463802.XAFRqVoOGU@amaterasu.liwjatan.org>
MIME-Version: 1.0

Hi everyone,

It looks like this broke the bootconfig tests (tools/bootconfig/test-
bootconfig.sh), tested on 6.1.18:

Max node number check
test case 12 (./bootconfig -a ./temp-HCfT.bconf ./initrd-NGHv)...
Apply ./temp-HCfT.bconf to ./initrd-NGHv
        Number of nodes: 1024
        Size: 8110 bytes
        Checksum: 599485
\t\t[OK]
test case 13 (./bootconfig -a ./temp-HCfT.bconf ./initrd-NGHv)...
Apply ./temp-HCfT.bconf to ./initrd-NGHv
        Number of nodes: 1025
        Size: 8118 bytes
        Checksum: 600212
\t\t[NG]

When I adjust the max node number for the tests to 8192, test case 13 passes, 
but test case 12 then fails:

Max node number check
test case 12 (./bootconfig -a ./temp-qZHF.bconf ./initrd-0v99)...
Error: Config data is too big.
\t\t[NG]
test case 13 (./bootconfig -a ./temp-qZHF.bconf ./initrd-0v99)...
Error: Config data is too big.
\t\t[OK]

Grs,
Heinz
--nextPart3495801.dWV9SEqChM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQQRpqSSOxrcqQ33x62nXtwz5SpGygUCZA28WAAKCRCnXtwz5SpG
yreHAPwJ16URROnru2WUBTmEhFf7eEdVZIp16cKWGOX/93mhKwD+MgdBT1Eek+dq
OIIgZwiaAMvDJZOaXdXiMp6NbBpXIJ4=
=vWpW
-----END PGP SIGNATURE-----

--nextPart3495801.dWV9SEqChM--



