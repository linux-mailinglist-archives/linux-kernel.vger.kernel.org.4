Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B466B056
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 11:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjAOKcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 05:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjAOKcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 05:32:21 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2097.outbound.protection.outlook.com [40.92.98.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B50C16B;
        Sun, 15 Jan 2023 02:32:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEZf39pkFpQmVt7Qku3LGFX/wlJeiKGbRoTCJR/QBnjCbtQaK9elkjpi6WUWG/PzzUpLBFItKkycUhOomsRXOgYfiG7hsZ/qsUpCgZjbX5l70SODEzbPEBpoZaBk6eh0EfW7b2YrXq5M9GT8XpInqnFBBXqQXB+4PFAKIuKyXnsAJuLFztc3lPxzpkCjN7/9L11DWrjZ08sxzDWZLhdloRYcGlXALvdwZzCqbmlJ5+9/cgmA6qn1uUEBMM2PBSlMNJeqeeizkcAgm8JOaOuR2JAvKYC/vDv8CXiNafQnn1X3kayhfXRH/G58GH7MO5DnCcTp0ASaAnMpV2jpYrr8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1/qUEJuTjNq9et9JCnYcwWdMajyUbf3L6UqtV1eIp4=;
 b=Mccrh7vEp/6ftJpRCk9BSWfH3e6z912cNmM14h+rY9saqx7RuU2BCeFaFmGrU5pMV4MybQvXBGLRKFfNWmBM/2hrMSCmDiQy8tNlpMd1X4A4roYE2j02sByGmLDU4SgvX+nT4lwIRRoJAnzhNiGtrzhf3DBpmqP1DPURReoUzKE8fw9oBBUaX7C5zgSygL5qqABMpBS5ak3zDI1Sak/csPsRICtfDnDns3yVQXjOT/PpcJGZ76JAf1bTkPpCiUKI0vlbe8lSi8znlT9ocDc9hgr9SbgI3S0PI3LzzvsE2MhBFOMzWPiI6EaEWFyeEsOUxUGsBzYIECOHb4lNjdyelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1/qUEJuTjNq9et9JCnYcwWdMajyUbf3L6UqtV1eIp4=;
 b=SytVcgIeqhgV2Jevs+zT6f/1W8ZZ/Tq3UbJxrkR2DVE5hvdKL5xWNfIS1aHT7xQJxJ1FDV/NTFNCG3NO5aumCDJtBGcNMYWeLEwKfogKoRaJlr0Pp5JkFRK/1vVh8CYJxTJ9tc2hFsMDIgmog3ytEjguuMhay4X0Qd6gFNSBAnFCDWGzGj/NcsJv4KvqeaKxDXPLbILcA3u8SSlBioip4qIIZ0DLO9KlPCMg9MCFGrbSdcGfoBedhW0Pp9gzI8t+acvr4GkBZX5H8Ui9U986JXSngjgDm5YGFQkMGdyySPG+EWeNSvhwMLTME/EKQR5h7WIhYCIPLV7nRjr8WMvZ8g==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB2025.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sun, 15 Jan
 2023 10:32:17 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.6002.012; Sun, 15 Jan 2023
 10:32:17 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     linkinjeon@kernel.org, sfrench@samba.org
Cc:     senozhatsky@chromium.org, tom@talpey.com, hyc.lee@gmail.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6]  ksmbd: Minor performance improvement & code cleanup
Date:   Sun, 15 Jan 2023 18:32:03 +0800
Message-ID: <TYCP286MB23239EE29037F6051CFE5691CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [d0E2ssGt2yAPHeaClCLOtElkHUHTRapm371fmQ2f9gE=]
X-ClientProxiedBy: TYAPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:404:29::30) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230115103209.146002-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB2025:EE_
X-MS-Office365-Filtering-Correlation-Id: dcedf621-c5db-4596-4dc6-08daf6e3c637
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtBlAQDgVmtVMz+TFqCyVSyQ0xzeffJpKOmoTH39AJhEUnYkXAeT9ivN7aLAlhL8FvRwLXI1OFGyf7OgsqyxKV0LF9LYlrRH6AIq6bPY58YSc0frFem1a+xAJe/suJhayIxWRp1MXcCcOk2TgxAONDAjY8f3+u7OGzuM2Wkgset9ORU4EGK53Sz7sp8AI3s7GkL/vuaWCYIVXy0fURB6ZI4b6BM8iZcO4+ZwUMi4nonjT5i/n2TDlg3wwR+lgAw49syfZFCbpwNaQzOfVG7kM22Vk9OIt8ovZTQCqjlLOpj9YXSleyofznNp1C02m2OQKAtU2CRUt5GpLqc5TcBWKH2waxnWMBui/J6mSTCvlzBf4AadGFsMTSKA7sjko1bWImwTBTZrohf6CvEYEKe21kCS162uw62FWAHvcZ2xF8yekb5r5/l45EXRcoTqGwUYqfpn8wqvQ83KmGtnTS89t7tORIfA6aD4tE436YNesdYs8DrpYe81wP4Z6TbYFDUn5hUGj4W5VTtJ53W/UxJ1zgtUwvbNsITS8wL4yW/jfaDabBS8+7f87nuzL9p3tvbjw8KF9EWsF+bpoXrRe2gLpXF0kwdG4d6OrujgMxF43OQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IErFZmZA3crEKhBWJ6z40le1oHxMkPT0dpa65/X3lp+ZigqxwLp2XBp7BshN?=
 =?us-ascii?Q?21kRKRTflm3r95lMeF7OzfpED9zV0KA6c1K0EgGojiEsjlwaV9r/ZJjQ42Sk?=
 =?us-ascii?Q?3zJWE3MA2A1G2/7EbkYt68u7O/CVfkyMCbWDXhr1txxcXX0jG9JGSkMpxTHZ?=
 =?us-ascii?Q?DTtf+grql97ujnOtaxA7ECD2xaWddoFn6/lpsIlTXxirgwLcJ6uGXKvyZ1Nr?=
 =?us-ascii?Q?/ZiZZSUXgGVWhkLOY8H6yKgnrnAmNnWiIUpk83egjoYedwnlyNkSFcVb7My6?=
 =?us-ascii?Q?SrVoAQ6rD3klUce54cq5dY2fc7ee+HftzCzRSxCW3DJgF2Nhtb1lKCT7rw+u?=
 =?us-ascii?Q?XhgFgNDHFhaoYV09OgGMUIWx4rwTb/eY1LgGx25jLUK8NLxiWg7EsCvelfGc?=
 =?us-ascii?Q?kivvIeRUOlx1VHJ1KXWf/VGKvIgSkERH2Kb/dBKivRJ1U6ywu5ZrruX3Pn8y?=
 =?us-ascii?Q?L2tPdTnA6rXuCsYFa0A/EBCZXJL/saTnWE7y9Lfca82K3yqyXrNfffJoEedm?=
 =?us-ascii?Q?XYZFIppprYmA7TmKzqQl7j1/pVXdgg4T8ABxEt5PBsRhNBRE36bK2uwas7KO?=
 =?us-ascii?Q?tJAsL5ag5epTRRWf/5yZ7GMWTu0/JAi0l00vaf4BT5kUHtUAdvNJ7HWiKQGH?=
 =?us-ascii?Q?kGCw3HCyhzuf13VnNOpBAv1pZWf2iYWDrzGnWaAxZgbO30sd+ZZRBbW+Z8g2?=
 =?us-ascii?Q?gIdNYw8fsis32mfCXM2VYriiW/bDKnTbsoEBvOPqdHx6e+pLk9XKpWHYl+ON?=
 =?us-ascii?Q?u9sHnfpVF5sVaEAymlr9WgEFsY1kRLbo7/4Ygab/TbWWWCPmzVQJOL9dmEvy?=
 =?us-ascii?Q?xUagrt3nxrc2rkhOYS6/NoRPu29IlFM7xicLD0/x1DsIpxGu3KPzRKZ4wtSd?=
 =?us-ascii?Q?JvV1ajyqE1YOsBk6c4ckYzBYU3KZNKLF6B4tAaBepp0UpZRfX9+Dfrss4l/X?=
 =?us-ascii?Q?J4hmv4AasrP4MKo19I8C0FjPC0j+H0CnfLmT/V0g1J51vV9Wk/rwujGt9mf5?=
 =?us-ascii?Q?ROXU3iDBt6j0o65Ptsw918+ffw5S1ZL9P7jK6gR5xGSiSMR/qQKCpFuJLjUm?=
 =?us-ascii?Q?b36VfiKRhHe+oEA7czZWCQjfAhdttLjjyRWMHXfNSF2EXV5PRqqxT1H/zlWp?=
 =?us-ascii?Q?nGw9O1QRP5SmQ8URQbyQDVILhGyycpdND4HYSeN+2r/QRTFWOUcVLIKo+2+f?=
 =?us-ascii?Q?PgsskelHf3YR/S2t7mSsUUAuyavqeRSVA4WJRfb4tjDCZZdvTfPrAtLw/WDG?=
 =?us-ascii?Q?3zesNK8Pl2GPZH6/r9y0YYbb8rnsM/sS0dfse9ho4mSzs9AvzwRhn8QC6i1d?=
 =?us-ascii?Q?ex8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcedf621-c5db-4596-4dc6-08daf6e3c637
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 10:32:17.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a small series mostly aimed at performance improvement and code
cleanup.

Among which, First three ones are performance related commits, and
other ones are minor code cleanup.

1 & 2: list => xarray, acclerating index based lookup.
3: rwlock => rcu primitive, enabling write & read concurrency.
4: Simple duplicated code removal.
5: Minor code rework and exception handling.
6: Simple typo fix.

Dawei Li (6):
  ksmbd: Implements sess->ksmbd_chann_list as xarray
  ksmbd: Implements sess->rpc_handle_list as xarray
  ksmbd: replace rwlock with rcu for concurrenct access on conn list
  ksmbd: Remove duplicated codes
  ksmbd: improve exception handling and avoid redundant sanity check in
    loop
  ksmbd: fix typo, syncronous->synchronous

 fs/ksmbd/asn1.c              | 19 ++++---
 fs/ksmbd/connection.c        | 54 +++++++++++---------
 fs/ksmbd/connection.h        |  1 -
 fs/ksmbd/ksmbd_work.h        |  2 +-
 fs/ksmbd/mgmt/user_session.c | 98 ++++++++++++++----------------------
 fs/ksmbd/mgmt/user_session.h |  6 +--
 fs/ksmbd/smb2pdu.c           | 52 ++++++-------------
 7 files changed, 93 insertions(+), 139 deletions(-)

-- 
2.25.1

