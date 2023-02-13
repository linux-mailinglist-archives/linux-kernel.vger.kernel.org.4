Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D4694ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBMSHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjBMSH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:07:27 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C112C647;
        Mon, 13 Feb 2023 10:06:59 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DF4ojM001249;
        Mon, 13 Feb 2023 19:06:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=selector1; bh=lFvVE6a0bpKOP2vnegCzoLsc/2F0/jk1UuFDh9YzM0A=;
 b=h35cN+Sfa0RNuzqkx8c5jV4c3wZ0q6sUuR/SEKsyKrl8D9H7f7XebHDxVhPDxrthUFbI
 rjFN1EQ+Wv+9VuwfDToLWRcdQA+BNzzhW7WUZIwGlIIUPEp32jQVkyucU0qwraZZQAq1
 pkyBoFtkDyHTrUHgNXHG60MBMBtWu1i9gkm9kofV+eDr9L+eL3NU6wYi7B8l7EeZRs8h
 0oknRDp5bykgxJcJeRPcrB9eOAGRmt6OE4Y9aXj+TkEUVciLxKpmi7XBoPqOfR+XebxZ
 7kiFG5UB1n6PMmW0ArfnLZpnbRKVx1HwkNF0cJFidm7QcSg4C9Jb8MyN/Wa9DlUxBAqq vA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3np2spvj78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:06:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B971010002A;
        Mon, 13 Feb 2023 19:06:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A5AE62309C0;
        Mon, 13 Feb 2023 19:06:15 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 13 Feb
 2023 19:06:15 +0100
Date:   Mon, 13 Feb 2023 19:06:08 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Colin Ian King <colin.i.king@gmail.com>
CC:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] drm/sti: Fix spelling mistake "top_cmd_offest" ->
 "top_cmd_offset"
Message-ID: <20230213180608.GA1925841@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Colin Ian King <colin.i.king@gmail.com>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213100522.106595-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230213100522.106595-1-colin.i.king@gmail.com>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_11,2023-02-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the patch.


On Mon, Feb 13, 2023 at 10:05:22AM +0000, Colin Ian King wrote:
> There is a spelling mistake in a variable name. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/sti/sti_hqvdp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
> index 02b77279f6e4..711a6e333afc 100644
> --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> @@ -797,7 +797,7 @@ static void sti_hqvdp_disable(struct sti_hqvdp *hqvdp)
>  static int sti_hqvdp_vtg_cb(struct notifier_block *nb, unsigned long evt, void *data)
>  {
>  	struct sti_hqvdp *hqvdp = container_of(nb, struct sti_hqvdp, vtg_nb);
> -	int btm_cmd_offset, top_cmd_offest;
> +	int btm_cmd_offset, top_cmd_offset;
>  	struct sti_hqvdp_cmd *btm_cmd, *top_cmd;
>  
>  	if ((evt != VTG_TOP_FIELD_EVENT) && (evt != VTG_BOTTOM_FIELD_EVENT)) {
> @@ -816,14 +816,14 @@ static int sti_hqvdp_vtg_cb(struct notifier_block *nb, unsigned long evt, void *
>  	if (hqvdp->btm_field_pending) {
>  		/* Create the btm field command from the current one */
>  		btm_cmd_offset = sti_hqvdp_get_free_cmd(hqvdp);
> -		top_cmd_offest = sti_hqvdp_get_curr_cmd(hqvdp);
> -		if ((btm_cmd_offset == -1) || (top_cmd_offest == -1)) {
> +		top_cmd_offset = sti_hqvdp_get_curr_cmd(hqvdp);
> +		if ((btm_cmd_offset == -1) || (top_cmd_offset == -1)) {
>  			DRM_DEBUG_DRIVER("Warning: no cmd, will skip field\n");
>  			return -EBUSY;
>  		}
>  
>  		btm_cmd = hqvdp->hqvdp_cmd + btm_cmd_offset;
> -		top_cmd = hqvdp->hqvdp_cmd + top_cmd_offest;
> +		top_cmd = hqvdp->hqvdp_cmd + top_cmd_offset;
>  
>  		memcpy(btm_cmd, top_cmd, sizeof(*btm_cmd));
>  
> -- 

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Alain

> 2.30.2
> 
