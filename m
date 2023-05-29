Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B8A715204
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjE2Wp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjE2Wpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:45:54 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C32C7;
        Mon, 29 May 2023 15:45:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D7B05C007D;
        Mon, 29 May 2023 18:45:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 May 2023 18:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1685400350; x=1685486750; bh=bgUG0LgYa+nh+rJ4ie+IkG0Q0
        XRNLEsbQrNkQi4S5Fo=; b=ddLQxpXTJmdfbY0O8E4Tmy+qs8Orc4cxwMmYMbghr
        Coy5CGunqgA/jgfnfdKES+ofnIeQ7YEFS7Yx/W4jGFpG83lG6GTiBmc7pb31STso
        dd3mF9VJ17HzUarq5aII/xMMs05R2spM2LHpnjLr7hNchO+84dnW7xKn4/WVxZtS
        hmwazfByLtsV0rga1R7JVd2o0lJZ3X/EHO6Xa3FIX3707x47qzAIugBvGqpXtnqX
        AhVxEgQgjT7dSJaLYFV3Lqlw5zsWaz41igkrg1sURFH9cLbsm8w5D083PacYmEk5
        euP1ey/ppOniFyXcChvvgAT2pdWNT43syrNkNyh4izP5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685400350; x=1685486750; bh=bgUG0LgYa+nh+rJ4ie+IkG0Q0XRNLEsbQrN
        kQi4S5Fo=; b=m02MiaP6vAxok/Lty6E/V6DYMW+CyjvuBA6mpiHVkl4phqzCfyN
        At1JCcjKlEcrGJAUJYMDOc+5f7/p71ycWh60Ycw7HNRCPZlU9+/30/CX5b4kJojh
        6bVr9CXui/DhoHQLJ+Y3mH7QtSd0t5LaTYo7vuEQGKY/TfjzBFeYjk+ZjUzY0IkZ
        qxUvxX54b2u/wmW2ZEAOIplN5ZzPucPcmztvpOnjctNX6qGuaRKlZWD9II/vZk1g
        w9IKbq2R/Iu87Z4RaoKV/wQZtpw8/5FS7ZiCle/4QqIOReewQuISSlf7Djeb7fEb
        wyz+TDe/Eow5xkklxQeF/FM9tHZf2q3IqyQ==
X-ME-Sender: <xms:HSt1ZFCyn9izx8vsp_Vc1U7mY-q0KGKV65h-NxuD9UO5whK0PSEkNA>
    <xme:HSt1ZDjo6L9ZnrPjCxKZw1GVkdlPFPCdz4SsG2RkQe20tnJY_FnxMiQK7W3YHurNi
    45lBCORR_iIVHf0bS4>
X-ME-Received: <xmr:HSt1ZAmIzZG-HN2zJCEcnP58H3MDBDoYY3KHbbYdqLjIkQeXusO4x807VdI8qt3cu3Gp5hJ8w0RyCggqd1fjSKlrNaaCgZo7x-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekiedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesth
    ekredttddtjeenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgr
    khgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnheptedthe
    egtdfgfffggeehhefgtdefueelteelfeduudeludeggfelffegfeeiudejnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhdpghhnuhdrohhrghdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:HSt1ZPxt6jcgR1IuHbin3IzMCoQLK7myanau5vZqDzDwvjeFU7DQrQ>
    <xmx:HSt1ZKQANZZOBjMwQmPmOBaNIM47c5zunCcczG1Cdw-QKiQZ0jR4Bg>
    <xmx:HSt1ZCY6O-PfoQ75-5ClWhbZosX1DKUbFDzHmbV15U0mKSGlNLpUHQ>
    <xmx:Hit1ZFf-ufi8dc8V9C2O83rlKmoYQF55qonfSAP9RcCY6DuPNsVX-A>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 18:45:48 -0400 (EDT)
Date:   Tue, 30 May 2023 07:45:46 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] firewire: Replace zero-length array with
 flexible-array member
Message-ID: <20230529224546.GA8560@workstation.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZHT0V3SpvHyxCv5W@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHT0V3SpvHyxCv5W@work>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 29, 2023 at 12:52:07PM -0600, Gustavo A. R. Silva wrote:
> Zero-length and one-element arrays are deprecated, and we are moving
> towards adopting C99 flexible-array members, instead.
> 
> Address the following warnings found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
> sound/firewire/amdtp-stream.c: In function ‘build_it_pkt_header’:
> sound/firewire/amdtp-stream.c:694:17: warning: ‘generate_cip_header’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
>   694 |                 generate_cip_header(s, cip_header, data_block_counter, syt);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/firewire/amdtp-stream.c:694:17: note: referencing argument 2 of type ‘__be32[2]’ {aka ‘unsigned int[2]’}
> sound/firewire/amdtp-stream.c:667:13: note: in a call to function ‘generate_cip_header’
>   667 | static void generate_cip_header(struct amdtp_stream *s, __be32 cip_header[2],
>       |             ^~~~~~~~~~~~~~~~~~~
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/303
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/firewire.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the patch. I applied it to for-linus branch as a fix for
v6.4-rc4, instead of for-next branch.

* https://git.kernel.org/ieee1394/linux1394/c/41dd10a086c5


Thanks

Takashi Sakamoto
