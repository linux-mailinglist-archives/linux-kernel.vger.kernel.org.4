Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419D05F3BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 05:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJDDvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 23:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJDDv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:51:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233B523BDD;
        Mon,  3 Oct 2022 20:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47DFBB818F9;
        Tue,  4 Oct 2022 03:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1591C433D7;
        Tue,  4 Oct 2022 03:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664855480;
        bh=7C19wSpn+t2vL8jLxmz2DAFHyCNmoNWhZGqJqhx5eJM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eEby2yJrgqnxfmLT+5r2WZtOBb4qXgYIGc9utuUspPTeLxGH3KbId9ooWXM+Ol5JP
         GptRVuk+KVy7K+91Hrc+BNP4h6UAK+nP7fKR1I8fTBC3H8MCc+E2z6jWQj3tFxTNg9
         /se59jRXNC+0XDl0tpLaFRxyIG6gINT3CTLoKJuN8eCc/JlYKXfrRAmVKhJLo7CO5C
         oDwZccKuA5tYmX45UKRI6b5wUqYOv3k1AXm5gwL9ZogPbR5uCESW40JyPt70DAqbYW
         NAaw4q47e0VpFvlMzIekWeR5jWMoSY4ITSTTTmy4hc5yurDpFo6PQZdKYMJ+kUATe8
         FkUVlPPePWKvQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220914144743.17369-2-ansuelsmth@gmail.com>
References: <20220914144743.17369-1-ansuelsmth@gmail.com> <20220914144743.17369-2-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 2/2] clk: qcom: kpss-xcc: convert to parent data API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 03 Oct 2022 20:51:18 -0700
User-Agent: alot/0.10
Message-Id: <20221004035119.F1591C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christian Marangi (2022-09-14 07:47:43)
> Convert the driver to parent data API. From the Documentation pll8_vote
> and pxo should be declared in the DTS so fw_name can be used instead of
> parent_names. .name is changed to the legacy pxo_board following how
> it's declared in other drivers.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Applied to clk-next
