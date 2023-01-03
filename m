Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAAC65C30F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbjACPeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbjACPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:34:13 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1864A11C35
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:34:09 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230103153406euoutp02c179a02ba0f31401e810b6733ad8385c~21mZKjd100792907929euoutp02k
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:34:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230103153406euoutp02c179a02ba0f31401e810b6733ad8385c~21mZKjd100792907929euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672760046;
        bh=zrHnU49ZAL0MAHExvQ0jVVopZ6heoz/8cg5Bx6ptfh0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ki8xaC725EwaDuQuqmzWmShxuS8F1kXlDOpjrwX/SLVyOwnpAU2hR+yITsoC2GWHV
         mr64RzfQoYbbESePRSlJFaOSFY7k2IM9LEYg1P064zOuEom4yirEVLszoYBZ4PD6iq
         //PPXNBmZrersor6GcxAm9W/fWxpEGsjTcReKcnI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230103153406eucas1p1b74002209651a842f96c1a852d9fbcbb~21mY-0unS0967609676eucas1p1H;
        Tue,  3 Jan 2023 15:34:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 45.DD.61936.EEA44B36; Tue,  3
        Jan 2023 15:34:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230103153406eucas1p205c48bd767e6a86f6f1121db7eb5fc19~21mYyC9Ol3217932179eucas1p2C;
        Tue,  3 Jan 2023 15:34:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230103153406eusmtrp2031c67d3338df4947b11bf6ec35f1cba~21mYxYxtN2142621426eusmtrp2X;
        Tue,  3 Jan 2023 15:34:06 +0000 (GMT)
X-AuditID: cbfec7f4-a43ff7000002f1f0-58-63b44aee703c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4F.D2.52424.DEA44B36; Tue,  3
        Jan 2023 15:34:05 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230103153405eusmtip2ec3b5cfc53d28068124dcb087b2d0fb9~21mYjr02s3187831878eusmtip2F;
        Tue,  3 Jan 2023 15:34:05 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 3 Jan 2023 15:34:04 +0000
Date:   Tue, 3 Jan 2023 16:26:40 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
CC:     <axboe@kernel.dk>, <corbet@lwn.net>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <p.raghav@samsung.com>
Subject: Re: [PATCH v2 06/21] block, blksnap: module management interface
 functions
Message-ID: <20230103152558.wtpgxdbsc6tql3gx@blixen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-7-sergei.shtepa@veeam.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfSzUcRzH+/r97vzucvwcq8/0fFkrSmXabj2gsMw/UWqlzF3nhyuH3c/1
        ZJrykKc6Oz0cwykWjmrzcHFUOtNNZF0qavRIiTS6WlMh58f03+vz/r4/D+/tS2D8VJYTIY2J
        p+Qx4mgBm4vrHo13bvgWUCvZpB+xEVb2KdnC/uYLSHjvtavwelopLuzSF7CFhZmNmDfbv+uJ
        wr/kUi7LfzylheVvrl4eiIdwt4dT0dITlHyjp4gbZW4dto4btz31sG0QS0IXbDIRhwDSA9Q5
        2daZiEvwyXIEL4xvcKb4gWC4qxQxhRlBkemK1VyLMks76ypD0NxbMO8aVVdhTFGDIPlnErK0
        4KQz3P7ze3oLQbBJFziXYW2RHUlXGOvWsy1+jNQgyOvLnfE7kPvh4t2rMybe9LqJciPGsD20
        5fXjFsbI9VDc+J1tmYmRS6BskrDIHHIHNHb/mr1UAEk1HTjDifDuazbG8HMCRnt2MuwLWepX
        iGEHGDLWWjO8FKYaNLNzEmCg589MLiBTECgb7szsBXIbXOqIZjw74fKoEjGyLfSM2DNX2oJK
        dw1jZB6kp/EZ9xqoP1+HctDq/P9y5f+XK38+VzHCtGgxpaBlkRTtHkOddKPFMloRE+kmiZVV
        o+mf0j5p/FGPyobG3AzIikAGBAQmcOSpBqslfF64+PQZSh4bJldEU7QBLSFwwWKeuk4j4ZOR
        4njqOEXFUfK5VyuC45RkJWg/9ErUXMXymlJ6fcnXY51Ne0ZauFs/Bfr5yc/2s1Vj2k2JQaI0
        daMvf+9TQ9AGXRt9v9Au1L2oSurk1HBrdB/rxJtd7+wUdQW/D7jtfis7NhmwlgrwCD5K6NQm
        2cIpZ+VbrU+IJn2cs94c0lIrbzEWh52SPlzg/ddHdXXZUOiAT+UiQhtsCtGnaujKLBFham3P
        +gQ3jHEfL4caOIkRoihaW5bcVJ5yULngZ6jq8Wcsw9Oc2LfO90Fsx5Ez/BLVzWHXiqcfpZpi
        zGEFmLYNxrN6eysqvO4f7nlWSTevjKhP0Nl7vKxflYYPVExkSPipujajo+n9lmRN7IcEgQCn
        o8SbXTA5Lf4H2Wr8xZgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7pvvbYkG1zdYW6x+m4/m8WTA+2M
        FntvaVssbFvCYnF51xw2i7ldu5kd2Dwuny31WNw3mdXjZ8thVo/Pm+QCWKL0bIryS0tSFTLy
        i0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mj4ffc1e8JOv4uDJF8wN
        jO08XYycHBICJhL93atYQGwhgaWMEssmqUHEZSQ+XfnIDmELS/y51sXWxcgFVPORUeJmVycz
        hLOZUaLhbTsbSBWLgIrEut+/gDo4ONgEtCQaO8GaRQS0JT5e3wXWzCwwn1Fi5t3JjCAJYYFQ
        id7t08CKeIGu+LviODPEFfkSbbvuskDEBSVOznwCZjML6Egs2P2JDWQ+s4C0xPJ/HCBhTgFb
        id3XvzNBHKok0bD5DAuEXSux6fV6pgmMwrOQTJqFZNIshEkLGJlXMYqklhbnpucWG+kVJ+YW
        l+al6yXn525iBEbWtmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8k15sShbiTUmsrEotyo8vKs1J
        LT7EaAoMiYnMUqLJ+cDYziuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi
        4JRqYKpJ+FkRNU+SR/zoocm3+ORjvq3QzdJW/zzhqqCQ8Nf33ryz735/1SQwc90E12TG0uyc
        gKN/2LTC310M99Fp+/p7+731f049NmnLLj0aJSr0RH9GhcVjn2UPFl+4Kqe78GZUs+Idlb6z
        Nu8SXF7Ix2q8ezpr7d20xjN/uOZ8mBfv1CyqsnxDxfT7t7KLOdytVnO453FI9jzMyOP4otqc
        1tZ/4om27E2J4LkXL8a3vI3bsS+eN5l9i5vEnzNifT+CS1gYi5cusbRslDlz8ePC4wYlNvom
        MvPaNzSITp5enX6Xx0UzmYd7pqHC2W1BtioP7cW3zP/Ycl9q6wbjSYLbfm89fOdmy+I4/rMm
        X/X3iyuxFGckGmoxFxUnAgDYfrm3NQMAAA==
X-CMS-MailID: 20230103153406eucas1p205c48bd767e6a86f6f1121db7eb5fc19
X-Msg-Generator: CA
X-RootMTR: 20230103153406eucas1p205c48bd767e6a86f6f1121db7eb5fc19
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230103153406eucas1p205c48bd767e6a86f6f1121db7eb5fc19
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
        <20221209142331.26395-7-sergei.shtepa@veeam.com>
        <CGME20230103153406eucas1p205c48bd767e6a86f6f1121db7eb5fc19@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 03:23:16PM +0100, Sergei Shtepa wrote:
> +static int ioctl_tracker_mark_dirty_blocks(unsigned long arg)
> +{
> +	int ret = 0;
> +	struct blk_snap_tracker_mark_dirty_blocks karg;
> +	struct blk_snap_block_range *dirty_blocks_array;
> +
> +	if (copy_from_user(&karg, (void *)arg, sizeof(karg))) {
> +		pr_err("Unable to mark dirty blocks: invalid user buffer\n");
> +		return -ENODATA;
> +	}
> +
> +	dirty_blocks_array = kcalloc(
> +		karg.count, sizeof(struct blk_snap_block_range), GFP_KERNEL);
> +	if (!dirty_blocks_array)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(dirty_blocks_array, (void *)karg.dirty_blocks_array,
> +			   karg.count * sizeof(struct blk_snap_block_range))) {
> +		pr_err("Unable to mark dirty blocks: invalid user buffer\n");
> +		ret = -ENODATA;

Minor nit:
The following could be done to keep it consistent with other functions:

	if (copy_from_user(dirty_blocks_array, (void *)karg.dirty_blocks_array,
			   karg.count * sizeof(struct blk_snap_block_range))) {
		pr_err("Unable to mark dirty blocks: invalid user buffer\n");
		ret = -ENODATA;
		goto out;
	}

	if (karg.dev_id.mj == snapimage_major())
		ret = snapshot_mark_dirty_blocks(
			MKDEV(karg.dev_id.mj, karg.dev_id.mn),
			dirty_blocks_array, karg.count);
	else
		ret = tracker_mark_dirty_blocks(
			MKDEV(karg.dev_id.mj, karg.dev_id.mn),
			dirty_blocks_array, karg.count);
out:
	kfree(dirty_blocks_array);

	return ret;
}


> +	} else {
> +		if (karg.dev_id.mj == snapimage_major())
> +			ret = snapshot_mark_dirty_blocks(
> +				MKDEV(karg.dev_id.mj, karg.dev_id.mn),
> +				dirty_blocks_array, karg.count);
> +		else
> +			ret = tracker_mark_dirty_blocks(
> +				MKDEV(karg.dev_id.mj, karg.dev_id.mn),
> +				dirty_blocks_array, karg.count);
> +	}
> +
> +	kfree(dirty_blocks_array);
> +
> +	return ret;
> +}
> +
-- 
Pankaj Raghav
