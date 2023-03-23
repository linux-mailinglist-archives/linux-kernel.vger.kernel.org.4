Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939CC6C71CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCWUqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjCWUql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:46:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EB118B26;
        Thu, 23 Mar 2023 13:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 185E3628AC;
        Thu, 23 Mar 2023 20:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFF3C433D2;
        Thu, 23 Mar 2023 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679604395;
        bh=P6I0W6qPAsf0hZMdu29TtpwKztyniEZ29LfDRXsGq7w=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=HGkcOxq8/EGtQMuOQjnEgKzxYEn6jA+Tkv/UlOH6epkeISTnRnPz0LjAgMNk30+BK
         hzQ5nrKVAfC2B5/h8brgxFunzYp6nf1TL/P7rCn3bPcYN1Ylbp5EMeDdv4/cMfVOXx
         S359U2GjKhuUieB+GOYFFswsZU2VTyEgKYrw36fa4o0xaLiv6ntKlpGs9KGGJLxyKF
         ODuVJ5oPwQ5OHQcuBhUCQBVPGgGp7UL0ElTsGVFX4QPhHwHkEBtgeGGjCpigpJTeSs
         n8GOjvk6+xr2k1wgEoeJhRrSn4m7hc5Y3CxcBf0KwbB5//OlrdZn3Lc8Lb+rIMp8E2
         eAwY1Y9AOlGLg==
Message-ID: <8e0fac7e756272e2593e7c220f9ae69f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5b3fcceb-1a0d-d0c7-910d-eb4e65892676@quicinc.com>
References: <20230317141622.1926573-1-quic_mohs@quicinc.com> <20230317141622.1926573-5-quic_mohs@quicinc.com> <406d02f72767afafa8e563ec2ee7f310.sboyd@kernel.org> <5b3fcceb-1a0d-d0c7-910d-eb4e65892676@quicinc.com>
Subject: Re: [PATCH v9 4/4] clk: qcom: lpassaudiocc-sc7280: Modify qcom_cc_probe to qcom_cc_probe_by_index
From:   Stephen Boyd <sboyd@kernel.org>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_visr@quicinc.com
Date:   Thu, 23 Mar 2023 13:46:33 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mohammad Rafi Shaik (2023-03-23 00:45:26)
>=20
> On 3/17/2023 11:57 PM, Stephen Boyd wrote:
> > Quoting Mohammad Rafi Shaik (2023-03-17 07:16:22)
> >> Modify AHB clocks explicit registration from qcom_cc_probe to
> >> qcom_cc_probe_by_index.
> > Why? Isn't it the same?
> yes, it is same.
>=20
> As per the previous version review comment, modified qcom_cc_probe to=20
> qcom_cc_probe_by_index.

Previously you were probing with index 1. That necessitated using
qcom_cc_probe_by_index() instead of qcom_cc_probe(). That is no longer
the case though, so this patch is unnecessary.
