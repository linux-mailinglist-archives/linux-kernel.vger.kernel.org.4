Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5FF5E9547
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 20:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiIYSIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 14:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiIYSIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:08:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DF71F630;
        Sun, 25 Sep 2022 11:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghvj1Hn4rXJQ/nBcLvAlEwdVApwtMNURAa9COApLaT/sc9Jw+esAyJ6/64xSCze4f9Zjx8PxMG5nmet/X6YagJFylQylv9HQ4iaqddFdlGaB8WouXpKfX37h6EZXwUK8VzPtQ7bhjDNP7W35ZhloPdOcOl8h8QvDz6EgNvrivFXBoMc3atDTS1IJ6B+q+Jw72oSWYJ9O2gUQvfDW4C11Hd8KfYS5SzhvnCVGF0danmpAWnKvPUqT7wbpNv+XREhdvNTxEa/a0tQ7NSZRyLCo2K8hPAJ105So5zJzPTjT6l6SvcoDeOwvReN7hcRRmy0Zqm8CeZSUhQyC3NdbTLNdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTVvvZzu8JCMGsL/wzE9d/zHikByTOy/N+nAeETMTpU=;
 b=gEyAbI5Vny2uKPSUQvOVxX9kqwM+0E/LX8Md0/QxWCEK1TcwDjMCCImX2miDBnupLuJ6FDrgRBDbd53Ku3aVS6GpusID6TUHPemUeewbl4RMbBljxRd+evKy2+Js5lkLTDo8gBEMO5fhQ9DdPwfR+YtBHSuEQIFylV0rJwgr/1Wdk57RdtK6/yk8NrpYvjjTt55BdUyyYD7WfqSAt5Yu4fR3SLhUPA3I0M0A1mFua8iWI+oWVGB+8SnrohRgc98MROjvpSb7zA12ACgWTHsrgrOrTvJqDM5LioY3fF/9klctwByQrwzAmYVBVrWWebXDMs0VJeTdZ0OmdVM5/V3DlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTVvvZzu8JCMGsL/wzE9d/zHikByTOy/N+nAeETMTpU=;
 b=gZYvXMxCUjTW+5bq2OI+pseg9mBU4+1NQzRt7aZCE9RRZ0VUTE3rTkp8tZaQlj5D2mQznhjhr3K6cYtPTybmtQU4V7fi0ojW/ZqMUKzT+BD50kmBBk+2LI9NJCAF+2r6wLxo5qvlTkfxOOP8KOZaG0E4czM1obzfg1e1yLR+mjo=
Received: from SA0PR11CA0143.namprd11.prod.outlook.com (2603:10b6:806:131::28)
 by DM6PR02MB6512.namprd02.prod.outlook.com (2603:10b6:5:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 18:07:59 +0000
Received: from SN1NAM02FT0006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:131:cafe::ed) by SA0PR11CA0143.outlook.office365.com
 (2603:10b6:806:131::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24 via Frontend
 Transport; Sun, 25 Sep 2022 18:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0006.mail.protection.outlook.com (10.97.5.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Sun, 25 Sep 2022 18:07:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Sun, 25 Sep 2022 11:07:46 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 11:07:46 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 akumarma@amd.com,
 git@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 amit.kumar-mahapatra@amd.com,
 michal.simek@amd.com
Received: from [10.140.6.18] (port=44788 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1ocW2c-0001TD-6G; Sun, 25 Sep 2022 11:07:46 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 1/7] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Date:   Sun, 25 Sep 2022 23:37:33 +0530
Message-ID: <20220925180739.21612-2-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220925180739.21612-1-amit.kumar-mahapatra@xilinx.com>
References: <20220925180739.21612-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0006:EE_|DM6PR02MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b6fc2e-a3e5-45cd-049a-08da9f20e122
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fAlovJZSvJEm35tQmmNyF2LW7gz95oAFDc2R5U5rsfLYCdtLO+j6NE9CZ7gRn9gSIrasOOCeBfTNABYYvoKW5t0LVK3hRZCv6VqZ+wGdEgn64s04DsF9W5551p0OI4TnBnIAgpbixaKf7n9LOdmcPyviOLJCPDVKqm+1/l1QAyQcRBoGYVFgU5Ari7hsYJv0rn+07rA2KNeENps4KXHPUUa5yQpc33yatVTn1CXQqedBHUGpgY0X3vbC0nqFSXDXFGzaJFgYYho35aetsybL4mc6c3rbBohsvjFyv7Bg2xMlHcUVtoirGUBYdrf50BMI0KamsmBGIXGGUOJrL9/WVcgiJKBLRo/LqtVQQUf5LfTGrxIrclUvWGxLyXQS4S7J+P41/0hPZ5OeHVqqBP7rjFaxF0vpr4irHhSKyQcP4VZcwWilzyS57fCoo3bjgGg6A7WXYJu3MfEJj4v+W5atdtiHXIliG5YrWcSubxoZp7JniJmgkqmaov9QiTKh0ljV28ZbVFWsJundvZC82JL4sCNfnJhx8d0uA9R6pii0ukY9ZO9t5D0tzIEdTRvQiBqLMa56LJSrr6SUZ+nZDutworg2MhwzrlTbqY1IwnWBE9VdsSK1xrF8nCOutjKppFrbFMzCSW8kuxdmqCFG6mkL+sMEf96VBHrb0lSwCe8oJ4Tf09ROQNw8w6hm9XcK4t1p/M4kNYN88KUuN7OiIPN0EmL1+fQTLkLoQ5fmGdBEY+8K7cJUjVBq7gZ2+BVpbtieX/54je4WmjtcQMtOnw8V+y4/VMoIYzkFycG3y47AqQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(8936002)(5660300002)(7416002)(110136005)(8676002)(54906003)(9786002)(316002)(70586007)(70206006)(4326008)(83380400001)(40480700001)(82740400003)(47076005)(36860700001)(426003)(336012)(6666004)(7696005)(478600001)(26005)(356005)(2616005)(7636003)(186003)(1076003)(40460700003)(82310400005)(36756003)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 18:07:59.0281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b6fc2e-a3e5-45cd-049a-08da9f20e122
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document zynqmp_qspi ctrl and op_lock member description. It also adds
return documentation for 'zynqmp_qspi_setuprxdma' and zynqmp_qspi_read_op.

Fixes below kernel-doc warnings-

spi-zynqmp-gqspi.c:178: warning: Function parameter or member 'ctlr' not
described in 'zynqmp_qspi'
spi-zynqmp-gqspi.c:178: warning: Function parameter or member 'op_lock'
not described in 'zynqmp_qspi'

spi-zynqmp-gqspi.c:737: warning: No description found for return value of
'zynqmp_qspi_setuprxdma'
spi-zynqmp-gqspi.c:822: warning: No description found for return value of
'zynqmp_qspi_read_op'

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index c760aac070e5..973008a30a09 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -141,6 +141,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
 /**
  * struct zynqmp_qspi - Defines qspi driver instance
+ * @ctlr:		Pointer to the spi controller information
  * @regs:		Virtual address of the QSPI controller registers
  * @refclk:		Pointer to the peripheral clock
  * @pclk:		Pointer to the APB clock
@@ -157,6 +158,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @genfifoentry:	Used for storing the genfifoentry instruction.
  * @mode:		Defines the mode in which QSPI is operating
  * @data_completion:	completion structure
+ * @op_lock:		Operational lock
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -739,6 +741,8 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 /**
  * zynqmp_qspi_setuprxdma - This function sets up the RX DMA operation
  * @xqspi:	xqspi is a pointer to the GQSPI instance.
+ *
+ * Return:	0 on success; error value otherwise.
  */
 static int zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 {
@@ -823,6 +827,8 @@ static void zynqmp_qspi_write_op(struct zynqmp_qspi *xqspi, u8 tx_nbits,
  * @rx_nbits:	Receive buswidth.
  * @genfifoentry:	genfifoentry is pointer to the variable in which
  *			GENFIFO	mask is returned to calling function
+ *
+ * Return:	0 on success; error value otherwise.
  */
 static int zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8 rx_nbits,
 				u32 genfifoentry)
-- 
2.17.1

