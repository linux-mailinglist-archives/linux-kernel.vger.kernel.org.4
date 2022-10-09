Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8F5F8A79
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJIJ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJIJ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:57:58 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEDCEA4
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 02:57:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6D6F45C0105;
        Sun,  9 Oct 2022 05:57:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 09 Oct 2022 05:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665309474; x=
        1665395874; bh=FKXqb6yr1RBolgYqScvMfbf6w4DuQbOVKtH4nmQYveA=; b=N
        ZJ2tGpydGb7eovF2BDCSfhMZuN0ICeB0q1uRWCpZ7xtgCjZEWfHc0Dsuq4pYet2c
        Ywf8vpR0IXBVWllsRFAn39zOWCnLj5b/0RTFBwUF5tfUJx4FoSI81/iU6D7rvtnk
        S7Js0VqdROeSknmtYYyusTpOYdW6lW1zp8O/+aq44s3t/LUTsQJSON731hmX0nCU
        36lVj57MINDDSkUQJA+lWbKjdS6SFHtoqmpY8hRHr0bbo6T8q4jJJV9DzjVmrulS
        9URV1aaXjh7nI6steGNHDlWmPNOQkeqkE/yDQadGb5C1n6JPN+P/ZtmoD9YTZU98
        SKmWpFk3uTVuPsaAQOplQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665309474; x=
        1665395874; bh=FKXqb6yr1RBolgYqScvMfbf6w4DuQbOVKtH4nmQYveA=; b=W
        KsFyRQM11UtEGEwIpTbOZvwNr/viTYGDeVE6NLDKzqALKtNk+FfZjq38GnD0EA8Y
        r7jaMKn6PRKIIKjZc7c+DIls40b2C4vw7W7kZfzowK80jGOfR6FnI/v9jKYD64PR
        WYgB+zigGJhTXEkknA8Ej8af4W6Pj+swyFT+VTSD7HEmm8hHWRQkIUndOlB79nOW
        gHdSMNSzdUyT2McHu91LEl5enHs62aQ6i3nWau7f3RxlSorZXXvQsNGWF+5MqVHu
        +vP+RDA2dU/7v23R7B36oBuCKbSei77WznAUjlh+3gy16pyEZ3QQK/orpWFrhitb
        xMEr7LPYr2AAo+SXwnx2g==
X-ME-Sender: <xms:IZtCY5sq-wcvxuov-8p_jApm3x4SGxw4miJKh2mIeYCxv58VSapb6g>
    <xme:IZtCYyeCEgeJHGURWDCTb5RMhXqCs8WLDsnK1RZ0SZxCnt9Zh026kS8-oMYfXSDEY
    W6JYBACXgkAPiNLmuw>
X-ME-Received: <xmr:IZtCY8zMJGlyv63xn_JDfvp3v1db7r9Z6IoRQalWmEM5OTiX-E_pL8wthCtqxkw5jmzoxctyDSf1D9yy9iQekImhOecLUD9JI6fpgNzwtLdFGXAw0K1C3hY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejuddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptgfghfggufffkfhfvegjvffosehtqhhmtdhhtdejnecuhfhrohhmpefuvhgv
    nhcurfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepvdfhtdduuddvueejueffgfdukedvfeevgfeuieeivdeltdehgeeivefftdet
    kedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:IZtCYwPnnc06CcM_hGbC2Yb4gs9VFNDItkqK5YwJrQP6Dfkb7D2q5A>
    <xmx:IZtCY5_Szza073oUNPVSq-b38GCc6QuwsOefdC86L8k_2D6DjtrEig>
    <xmx:IZtCYwUkMpsuFZRmtLXeggrumq9H3nZpCcRJa5Tf_iaGXR50xqFUgw>
    <xmx:IptCYwVC3TyabU469FUuuB3zeLkIXUClDtXsoA7Y-pVzlh82z2ZMMA>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Oct 2022 05:57:53 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Sven Peter <sven@svenpeter.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Date:   Sun, 9 Oct 2022 11:57:41 +0200
Message-Id: <6B4AB90E-49B4-443E-ABB1-632912D94CE3@svenpeter.dev>
References: <45b9c3f6-af45-e22b-06e6-ae2a2e5bba7a@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <45b9c3f6-af45-e22b-06e6-ae2a2e5bba7a@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: iPhone Mail (20A362)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On 8. Oct 2022, at 16:06, Konrad Dybcio <konrad.dybcio@somainline.org> wro=
te:
>=20
> =EF=BB=BF
>=20
>> On 8.10.2022 11:33, Sven Peter wrote:
>>=20
>> Hi,
>>=20
>>>> On 7. Oct 2022, at 22:00, Konrad Dybcio <konrad.dybcio@somainline.org> w=
rote:
>>>=20
>>> =EF=BB=BFAdd support for A7-A11 SoCs by if-ing out some features only pr=
esent
>>> on A11 & newer (implementation-defined IPI & UNCORE registers).
>>>=20
>>> Also, annotate IPI regs support in the aic struct so that the driver
>>> can tell whether the SoC supports these, as they are written to,
>>> even if fast IPI is disabled.
>>=20
>> No.
>>=20
>>> This in turn causes a crash on older
>>> platforms, as the implemention-defined registers either do
>>> something else or are not supposed to be touched - definitely not a
>>> NOP though.
>>=20
>> This entire description needs to be rewritten. All you want to do is guar=
d both fastipi and uncore reg access on pre-A11.
>>=20
>>>=20
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>> Changes since v3:
>>> - Replace use_fast_ipi with has_uncore_ipi_regs in aic_init_cpu
>>> (logic error, this was written to regardless of FIPI usage before,
>>> but touching Sn_... regs on SoCs that don't explicitly use them for
>>> IPIs makes them sepuku..)
>>> - Drop A11 compatible
>>>=20
>>> drivers/irqchip/irq-apple-aic.c | 47 ++++++++++++++++++++++-----------
>>> 1 file changed, 32 insertions(+), 15 deletions(-)
>>>=20
>>> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple=
-aic.c
>>> index 1c2813ad8bbe..2609d6b60487 100644
>>> --- a/drivers/irqchip/irq-apple-aic.c
>>> +++ b/drivers/irqchip/irq-apple-aic.c
>>> @@ -230,6 +230,9 @@
>>>=20
>>> static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
>>>=20
>>> +/* True if UNCORE/UNCORE2 and Sn_... IPI registers are present (A11+) *=
/
>>> +static DEFINE_STATIC_KEY_TRUE(has_uncore_ipi_regs);
>>> +
>>> struct aic_info {
>>>   int version;
>>>=20
>>> @@ -246,6 +249,7 @@ struct aic_info {
>>>=20
>>>   /* Features */
>>>   bool fast_ipi;
>>> +    bool uncore_ipi_regs;
>>=20
>> Why two flags? Didn=E2=80=99t we come to the conclusion last time that fa=
stipi and uncore were introduced at the same time? Below you also either hav=
e both true or both false so there=E2=80=99s really no need to track both of=
 them.
>>=20
>>=20
>>> };
>>>=20
>>> static const struct aic_info aic1_info =3D {
>>> @@ -261,6 +265,7 @@ static const struct aic_info aic1_fipi_info =3D {
>>>   .event        =3D AIC_EVENT,
>>>   .target_cpu    =3D AIC_TARGET_CPU,
>>>=20
>>> +    .uncore_ipi_regs    =3D true,
>>>   .fast_ipi    =3D true,
>>> };
>>>=20
>>> @@ -269,6 +274,7 @@ static const struct aic_info aic2_info =3D {
>>>=20
>>>   .irq_cfg    =3D AIC2_IRQ_CFG,
>>>=20
>>> +    .uncore_ipi_regs    =3D true,
>>>   .fast_ipi    =3D true,
>>> };
>>>=20
>>> @@ -524,12 +530,14 @@ static void __exception_irq_entry aic_handle_fiq(s=
truct pt_regs *regs)
>>>    * we check for everything here, even things we don't support yet.
>>>    */
>>>=20
>>> -    if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
>>> -        if (static_branch_likely(&use_fast_ipi)) {
>>> -            aic_handle_ipi(regs);
>>> -        } else {
>>> -            pr_err_ratelimited("Fast IPI fired. Acking.\n");
>>> -            write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>>> +    if (static_branch_likely(&has_uncore_ipi_regs)) {
>>> +        if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
>>> +            if (static_branch_likely(&use_fast_ipi)) {
>>> +                aic_handle_ipi(regs);
>>> +            } else {
>>> +                pr_err_ratelimited("Fast IPI fired. Acking.\n");
>>> +                write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);=

>>=20
>> This still can=E2=80=99t be reached because both static branches will alw=
ays have the same value. Didn=E2=80=99t we also realize a version or two ago=
 that this can just be dropped?
>>=20
> Ok, so I didn't realize you wanted this to become a single variable - I th=
ought it would have
> been useful to keep them separate, as A7-A10 *should* use fast IPIs as far=
 as I'm aware, but
> they don't use the impl-defined registers for that (or at least not the sa=
me ones).

What makes you think that?=20

>=20
> For the sake of this patch, I can squash it into one as all known users to=
 date set both in the
> current form. Also, before this patch, "apple,aic" used to essentially be h=
as_uncore_ipi_regs=3Dtrue,
> use_fast_ipi=3Dfalse, but since there are no users, I assume that combinat=
ion is not useful to keep
> around?
>=20

That combination just doesn=E2=80=99t make any sense. It translates to =E2=80=
=9Cwe know the chip supports fastipi but we=E2=80=99re not gonna use it beca=
use we want everything to be slower!=E2=80=9D.

As I said before, I=E2=80=99m pretty sure that else block was just a leftove=
r from when this driver didn=E2=80=99t support fastipi at all but we already=
 knew that M1 supported it.


Sven


