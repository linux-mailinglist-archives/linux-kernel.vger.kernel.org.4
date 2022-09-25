Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3EF5E94B6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiIYRPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiIYRP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:15:29 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066C237EE;
        Sun, 25 Sep 2022 10:15:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 04B03580360;
        Sun, 25 Sep 2022 13:15:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 25 Sep 2022 13:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664126124; x=1664126724; bh=G7CmDINNFw
        Eug1pjE+IrFi+4XbDQVcMn0dRCfHoeG6c=; b=AYGxzRoZIo/HrkEutzvCA+d3/m
        b+m0UqHZ45iANR0iLsRweFOk/SaRXLqTRgwhcft8KcSPinkHB9JzC4VNTV/CLb3o
        QYm3Gz827xTLwablq6BNp/2nUKkyqWS7UiSQ5h/nbi/XL1FugXYxv6ogjvzonGRf
        Ayt6HN9Ceh611VLUCOIrLz0JMuFpsbl15AY70Hw8ngYnYwWhsfwEp5jYfTo2zrKc
        iZHRionXt2puymDcazZSPfgz8wZpIPmiqHg9Yo5hnXw0uKtdSsHvYQhxRTOyCTPM
        E9Icmk1UUFH3+vwH8T+m4XO7CucQOa57z6XkTEmU8Lt5WYsd0v268DSKmkTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i78e14604.fm2; t=1664126124; x=1664126724; bh=G7CmDINNFwEug1pjE+
        IrFi+4XbDQVcMn0dRCfHoeG6c=; b=EzZeoQrG7W605r0Om3MopheZDwVOdtpkKj
        1X77Vk4Ceq99J3z66b1hcRoY27seYwLIU+g47ow/G+bFdV5x/FA4igf2sZ/VAGbh
        ujiMumERpH2g5sdoqAnNyc3NcOfRtKF0+K9lxGI8/JcjT4D94vtdy6PAT6lzKNoH
        WOx9rUiTETPpUPCSLWZoU9M7iV76vVSt+F/FXoP8CdSMdI0ji70n43Gmu9AISu/C
        8A6yTDJJvwLH53S5V2H7PK+Q9gE05LvEwc/PT6sA7tp6+moaR5VUaUEzOQIwBPm9
        oLgOJ7x7pwJ7d9D/4/L92inqqobMzZxLuXQuh1VnmG/Sf4LlmOvQ==
X-ME-Sender: <xms:rIwwY4_pYjzCd1XjeUH6abAktRlXUwV_0ec88oyprJhcTRN_DDFDag>
    <xme:rIwwYwsIvi0T-eFRks7mOnmcIxzhKqvrxae3kO6l2kdJo-riSAP14N8iVKYV9PP6o
    RTDFu6VGyfrfEulk5k>
X-ME-Received: <xmr:rIwwY-CmpyAJBHWwMsxo9N3Eyqu3m1i_0lg-kN7ro-ZWYaF4lpnSD4k4Eg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegtddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhihl
    vghrucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvhedvtddthfefhfdtgfelheefgefgudejueevkeduveekvdegjedttdefgfel
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtoh
    guvgesthihhhhitghkshdrtghomh
X-ME-Proxy: <xmx:rIwwY4e5suIpVtlrLP9Z_3euaJ9CPXWwKIh-dMzVebNh2ybe4CC5pw>
    <xmx:rIwwY9MMgG8e1DwqevrwDWkTbVbdJThfsWX1KyKwaZZ8V9Hmh2LMhg>
    <xmx:rIwwYymkddLWUHivn8l26wajEyBBi42YoFarROgHmhm2O7vwAc61aw>
    <xmx:rIwwY73OHv-WfKk47DGVJounRGbqFVPWwcg2kgGKRKn42FDf7Y8lK8x_y7c>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Sep 2022 13:15:24 -0400 (EDT)
Date:   Sun, 25 Sep 2022 12:15:11 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: keystore: Fix typo 'the the' in comment
Message-ID: <20220925171511.GA59018@sequoia>
References: <20220722100212.79490-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722100212.79490-1-slark_xiao@163.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-22 18:02:12, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---

Thanks! I've applied the cleanup.

Tyler

>  fs/ecryptfs/keystore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 3fe41964c0d8..2452d6fd7062 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -878,7 +878,7 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
>   * @filename: This function kmalloc's the memory for the filename
>   * @filename_size: This function sets this to the amount of memory
>   *                 kmalloc'd for the filename
> - * @packet_size: This function sets this to the the number of octets
> + * @packet_size: This function sets this to the number of octets
>   *               in the packet parsed
>   * @mount_crypt_stat: The mount-wide cryptographic context
>   * @data: The memory location containing the start of the tag 70
> -- 
> 2.25.1
> 
