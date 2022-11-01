Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0BF614620
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKAJBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKAJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:01:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C77186DD;
        Tue,  1 Nov 2022 02:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E74961568;
        Tue,  1 Nov 2022 09:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E47C433D6;
        Tue,  1 Nov 2022 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667293299;
        bh=/l6xjH9YE6k/qmD9L/3uehZBNhad2DOqg7fgrAKNHes=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oH9+lEVJoHcPuZ/xMdwHYURN084RwbfeXBo2dLwSuB1bHDM81jNR+0wEzeDZitIpd
         gvAe0vpoQZdaESgqg/zmTjyXC7Hyfo8RpUiglv+hFXFthORBhFocHMij17j5+vD8ex
         2sZIIYn0acKObxwkhBh7a78eBoPYWCmiGRgMasK19Q5CFnZutjyZbQzVsJiSGozUWq
         ++nv0I/P3A6BIdGTNZPXGQgCWQTVvkogj17IWimmlBVbzuMNCz/O3/jNAdl5L6UgX5
         IDU63aPLQ2lbFJMVrjRhSQPLvDOyPBNP+Lvdy128Gh2lscuqCUi5/e2HlpJ6gxUspB
         bvQdNPJokczYA==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Youghandhar Chintala \(Temp\)" <quic_youghand@quicinc.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath10k: Add WLAN firmware image version info into smem
References: <20221026102257.19919-1-quic_youghand@quicinc.com>
        <b55ef95f-f400-9ef6-a427-525ae529d673@quicinc.com>
        <fd45187c-739c-cd5d-4d4b-ae6abad03a94@quicinc.com>
Date:   Tue, 01 Nov 2022 11:01:33 +0200
In-Reply-To: <fd45187c-739c-cd5d-4d4b-ae6abad03a94@quicinc.com> (Youghandhar
        Chintala's message of "Mon, 31 Oct 2022 12:24:43 +0530")
Message-ID: <877d0fgiaa.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(fixing quotation)

"Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com> writes:

> On 10/28/2022 12:19 AM, Jeff Johnson wrote:
>
>> On 10/26/2022 3:22 AM, Youghandhar Chintala wrote:

>>> =C2=A0 +static void ath10k_qmi_add_wlan_ver_smem(struct ath10k *ar, char
>>> *fw_build_id)
>>
>> const char *fw_build_id?
>>
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 u8 *smem_table_ptr;
>>> +=C2=A0=C2=A0=C2=A0 size_t smem_block_size;
>>> +=C2=A0=C2=A0=C2=A0 const u32 version_string_size =3D 128;
>>
>> should you s/128/MAX_BUILD_ID_LEN/ since that is what is used to
>> size qmi->fw_build_id?
>>
>> or alternately have the caller pass fw_build_id length as a separate
>> param?
>
> Sure Jeff. Will address it in next version of patch.

BTW Youghandhar, your quotes were broken in this mail so your reply was
difficult to find. See here:

https://patchwork.kernel.org/project/linux-wireless/patch/20221026102257.19=
919-1-quic_youghand@quicinc.com/

If you are using Outlook, I recommend switching to an application which
respects standards more :) For example, some people seem to be happy
with Thunderbird.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
