Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12D35FC7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJLOtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJLOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:49:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B531DCF196;
        Wed, 12 Oct 2022 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZAEoS8mUjnL5VE8t55zy1MwHS8C4pzjpQXMKrzCouUs=;
        t=1665586150; x=1666795750; b=uOrdDN+MdTLoltn8VHnyzZN5PmsrkWd5wyVGR+f99BknLOb
        JXwAamMKCMpqChp7kh+KaNXxwdOR7EOE1Rr/bQOL2/LjuV1CIgLP04Kw5NFzRkJcblehDXEcgD5Zb
        9YTwUiKNeAVhO2joscFiI6yQUWRWUBrCtD8m8V85pdOQfYsP/+1RWQG0+p2SOxjwYmfGO9OEkiLwL
        /EaK6uQ39mlKFGheZkCQYUqaJ1rpXP1WOO721EZOaVe6dNCglWyVkt4wU0zZzEzBzY9RQSIGAmV74
        rVD8IBiNxabpk8X1CQyl6BLKT2M93Lh9BV0EXMtgPbPbxIDmmxAnngwPwtBsfI+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oid2e-004pgo-0k;
        Wed, 12 Oct 2022 16:49:04 +0200
Message-ID: <1c64fe906b36438d63a7fc3fc9d0ab010b6db42f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: ath10k: Delay the unmapping of the buffer
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 12 Oct 2022 16:49:03 +0200
In-Reply-To: <20221012142733.32420-1-quic_youghand@quicinc.com>
References: <20221012142733.32420-1-quic_youghand@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-12 at 19:57 +0530, Youghandhar Chintala wrote:
>=20
> @@ -418,6 +426,7 @@ static const struct ath10k_hw_params ath10k_hw_params=
_list[] =3D {
>  		.dynamic_sar_support =3D false,
>  		.hw_restart_disconnect =3D false,
>  		.use_fw_tx_credits =3D true,
> +		.delay_unmap_buffer =3D false,
>=20

All the false are unnecessary and just distract from the content, imho.

johannes
