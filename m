Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC21760F5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbiJ0LBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiJ0LBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:01:10 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B42A23CC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:01:09 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221027110107epoutp0183dd3ca27596ae1fc19647cf0d08d659~h6AobHHal2297422974epoutp01f
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:01:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221027110107epoutp0183dd3ca27596ae1fc19647cf0d08d659~h6AobHHal2297422974epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666868467;
        bh=zdBki9bdU0qOtfM6DVu6TjON7wD1YRTDGHk32ctigcw=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=simfjoGt5nwUBPg2vhne5+BViBGXev3+BmEL5c6VPoBp3qWZul1YFuj80u2J/0wKy
         4YIXK/hgujzFVsuS2z2nRCPV0yDaMOoqzjAi/HqQ5phVNf9i+ulZ0NKvfAxK8Bgms6
         dHBaS5ksloMAoimvr3u1PIU3fyFojVWQ/izK6TKY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20221027110106epcas2p446203b379db421b1f43f1755d73abd8f~h6AoG8K021876418764epcas2p4V;
        Thu, 27 Oct 2022 11:01:06 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MyjQp3ywTz4x9Pq; Thu, 27 Oct
        2022 11:01:06 +0000 (GMT)
X-AuditID: b6c32a48-e61b9a800001494a-7f-635a64f2cf89
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.41.18762.2F46A536; Thu, 27 Oct 2022 20:01:06 +0900 (KST)
Mime-Version: 1.0
Subject: [f2fs-dev] [PATCH] f2fs: Fix typo in comments
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221027110105epcms2p10a8cc7e0e7c3b2960a8db4efaa574ae3@epcms2p1>
Date:   Thu, 27 Oct 2022 20:01:05 +0900
X-CMS-MailID: 20221027110105epcms2p10a8cc7e0e7c3b2960a8db4efaa574ae3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmme6nlKhkg73HpS1OTz3LZPHykKbF
        o9vPGC2erJ/FbHFpkbvF5V1z2BzYPDat6mTz2L3gM5NH35ZVjB6fN8kFsERl22SkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYArVZSKEvMKQUKBSQWFyvp
        29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGf82TuLreAha8X3
        C+tZGxifsHQxcnJICJhIrPu2jrWLkYtDSGAHo8SPk/eYuhg5OHgFBCX+7hAGqREWMJNYcmMV
        G4gtJKAk0bVwKzNE3EBi3fQ9YDabgJ7ElN93GEFsEYFXjBJnVotCzOeVmNH+FGqXtMT25VsZ
        IWwNiR/LepkhbFGJm6vfssPY74/Nh6oRkWi9dxaqRlDiwc/dUHFJidYzW9kg7HyJJzf7oebX
        SCzY/hkqri9xrWMjWJxXwFfi68XlYHNYBFQlvj7qYIKocZG4vWE3K4jNLCAvsf3tHGaQ15kF
        NCXW79IHMSUElCWO3GKB+aRh4292dDazAJ9Ex+G/cPEd855ATVeTeLRgCyuELSNxcc45qE88
        JHom/GKdwKg4CxHOs5DcMAvhhgWMzKsYxVILinPTU4uNCkzgUZucn7uJEZwGtTx2MM5++0Hv
        ECMTB+MhRgkOZiUR3rM3wpOFeFMSK6tSi/Lji0pzUosPMZoCfT+RWUo0OR+YiPNK4g1NLA1M
        zMwMzY1MDcyVxHm7ZmglCwmkJ5akZqemFqQWwfQxcXBKNTCl3Py3Nnch/83aa5wBnH28v//Y
        LXLVNtqWV7Au5PR6T6mdSl42J7/P3bT4x/R9lUqHjgn84mrkjJvGej5r/+aJb38aJYq+cslb
        pXL3umD5lzKp7OX3fq+9qBNm5y5avXfH+UVGgrGTH896duvpznmO9ozzt8VFO3zJS1i5a5X2
        G4+Kh3defJqpkv34MEduydOO08llHsUiX2OiqiUKT7qW8W08WPtlRtixmsUtM6+FbXifmbBc
        TnCbFnPJz7dlviyai8Kt3Qy2n3986rzthoOFFzUV7R4JS+btuMdy/WLHsxWKbMUbNFiPdaxg
        a7LgvP2ar//ccZGQWuXVwT8+SbmX3P+h47WN46LdfJ/sp1dVlViKMxINtZiLihMBPmKzpQwE
        AAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221027110105epcms2p10a8cc7e0e7c3b2960a8db4efaa574ae3
References: <CGME20221027110105epcms2p10a8cc7e0e7c3b2960a8db4efaa574ae3@epcms2p1>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change "truncateion" to "truncation".

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8cd52b0965b1..aafdf5fbb825 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -571,7 +571,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	raw_node = F2FS_NODE(dn->node_page);
 	addr = blkaddr_in_node(raw_node) + base + ofs;
 
-	/* Assumption: truncateion starts with cluster */
+	/* Assumption: truncation starts with cluster */
 	for (; count > 0; count--, addr++, dn->ofs_in_node++, cluster_index++) {
 		block_t blkaddr = le32_to_cpu(*addr);
 
-- 
2.17.1

