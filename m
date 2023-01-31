Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140A568324F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjAaQMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjAaQM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:12:29 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FA053577;
        Tue, 31 Jan 2023 08:12:26 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4P5qnb3mFMz9swG;
        Tue, 31 Jan 2023 17:12:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1675181539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BAmAVOxlICirsa2Nl80fiU1dNmvvUYA3aFbvUIXWEr8=;
        b=eA2M8WR7MZoQ9eTyXW/1Zk/QVcES24UXNJZsmYOzTi8XSMz9qrQWlKrCpZ5vFoG4xl+QVA
        D6FtLUrHcrZUyxKnShDErHiccaNAGDp5CSsn1ZORtA0fm3XXtojuCal2LkxRsEwJXWwAIY
        KkThCuMk3JfrUN0OA/h85uY/BzGK7YMDO+ugcnVBHtT2jEMnBx07YNjUgE/83EYiywVFDd
        HShk32kVARyeO7z5esUIrLxeS/rIbrMqQdcKTP/wvTp+Qu/cDiOqRaBRtrevL4jsXiliE0
        kvfvUDQQTEvdPoDCZTFMMBBVwsgpZRp6GI2PeQDxa9Emm5wNEkhGNbgXEhCLmA==
Date:   Tue, 31 Jan 2023 17:12:16 +0100 (CET)
From:   torvic9@mailbox.org
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Message-ID: <1762147554.29600.1675181536998@office.mailbox.org>
In-Reply-To: <5643269.DvuYhMxLoT@natalenko.name>
References: <20230131052141.96475-1-wyes.karny@amd.com>
 <1501106335.274.1675161471528@office.mailbox.org>
 <5643269.DvuYhMxLoT@natalenko.name>
Subject: Re: [PATCH v4 0/6] amd_pstate: Add guided autonomous mode support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: 6b4301c6880f73df26f
X-MBO-RS-META: 771etka38copawjw683gipdwowrsphqb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Oleksandr Natalenko <oleksandr@natalenko.name> hat am 31.01.2023 15:13 GM=
T geschrieben:
>=20
> =20
> Hello.

Hi,

>=20
> On =C3=BAter=C3=BD 31. ledna 2023 11:37:51 CET torvic9@mailbox.org wrote:
> > Can you rebase this patchset onto the newest EPP v12 series [1] ?
> >=20
> > [1] https://lore.kernel.org/linux-pm/20230131090016.3970625-1-perry.yua=
n@amd.com/
>=20
> You may consider trying my rebase here: [1].
>=20
> This commit applies to v11+v3 series. I hope I didn't miss anything.
>=20
> If interested, please let me know whether it works for you.

Thank you for your work. I rebased it myself in the meantime.

>=20
> Thanks.
>=20
> [1] https://codeberg.org/pf-kernel/linux/commit/438525b8029b23967722e9c7a=
f97c6b8deb25029
>=20
> --=20
> Oleksandr Natalenko (post-factum)
