Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906E3750A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGLOHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLOHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:07:16 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EF7CE;
        Wed, 12 Jul 2023 07:07:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B21CC20005;
        Wed, 12 Jul 2023 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689170832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n5IHQuA27qiOiH8a39WaQrpxnP/EvNXlH49RRPiCc2A=;
        b=iGhP9MDx1FxD7wA03pM7rNHHscmxbZxD8QTWHzrUdufIyFHK2GUyS5Y36wl+upE68A4rt9
        2NxuCnzNm5sldKV4+sAYC1YJeS4K/Lz/JrV+18jVjxhTeCBlSMUC4ZjxzOU1WVUs8AzR76
        zZK3i6UZy1AVFEDbOoYFuD5eusmkmfJbglOW9nLoCoW+sialKIJ2ok3mgknEeZSgepK0iG
        M1jySZflp4AH2Cow/9dfc3HtbrTbI52YnmZCJhMpkcJGMk82Wxze8VuCbAXBEW2ldAZ2lw
        Q0QmxnRj12iEWe6NdFZpN2atBu27Ns3lrhLcJvmt5RHZsAvv6ws1jo8Ozkp0Pg==
Date:   Wed, 12 Jul 2023 16:07:09 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Message-ID: <ZK6zjaJtulRSrn7P@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes>
 <c46d0c53b7e5dc8dcdf7925f3d892024390a8b2b.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u6AcEc8pxRb1aObE"
Content-Disposition: inline
In-Reply-To: <c46d0c53b7e5dc8dcdf7925f3d892024390a8b2b.camel@collabora.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u6AcEc8pxRb1aObE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

Thanks for the quick reply!

On Tue 11 Jul 23, 14:18, Nicolas Dufresne wrote:
> Le mardi 11 juillet 2023 =C3=A0 19:12 +0200, Paul Kocialkowski a =C3=A9cr=
it=C2=A0:
> > Hi everyone!
> >=20
> > After various discussions following Andrzej's talk at EOSS, feedback fr=
om the
> > Media Summit (which I could not attend unfortunately) and various direct
> > discussions, I have compiled some thoughts and ideas about stateless en=
coders
> > support with various proposals. This is the result of a few years of in=
terest
> > in the topic, after working on a PoC for the Hantro H1 using the hantro=
 driver,
> > which turned out to have numerous design issues.
> >=20
> > I am now working on a H.264 encoder driver for Allwinner platforms (cur=
rently
> > focusing on the V3/V3s), which already provides some usable bitstream a=
nd will
> > be published soon.
> >=20
> > This is a very long email where I've tried to split things into distinc=
t topics
> > and explain a few concepts to make sure everyone is on the same page.
> >=20
> > # Bitstream Headers
> >=20
> > Stateless encoders typically do not generate all the bitstream headers =
and
> > sometimes no header at all (e.g. Allwinner encoder does not even produc=
e slice
> > headers). There's often some hardware block that makes bit-level writin=
g to the
> > destination buffer easier (deals with alignment, etc).
> >=20
> > The values of the bitstream headers must be in line with how the compre=
ssed
> > data bitstream is generated and generally follow the codec specificatio=
n.
> > Some encoders might allow configuring all the fields found in the heade=
rs,
> > others may only allow configuring a few or have specific constraints re=
garding
> > which values are allowed.
> >=20
> > As a result, we cannot expect that any given encoder is able to produce=
 frames
> > for any set of headers. Reporting related constraints and limitations (=
beyond
> > profile/level) seems quite difficult and error-prone.
> >=20
> > So it seems that keeping header generation in-kernel only (close to whe=
re the
> > hardware is actually configured) is the safest approach.
>=20
> This seems to match with what happened with the Hantro VP8 proof of conce=
pt. The
> encoder does not produce the frame header, but also, it produces 2 encoded
> buffers which cannot be made contiguous at the hardware level. This notio=
n of
> plane in coded data wasn't something that blended well with the rest of t=
he API
> and we didn't want to copy in the kernel while the userspace would also be
> forced to copy to align the headers. Our conclusion was that it was best =
to
> generate the headers and copy both segment before delivering to userspace=
=2E I
> suspect this type of situation will be quite common.

Makes sense! I guess the same will need to be done for Hantro H1 H.264 enco=
ding
(in my PoC the software-generated headers were crafted in userspace and did=
n't
have to be part of the same buffer as the coded data).

> >=20
> > # Codec Features
> >=20
> > Codecs have many variable features that can be enabled or not and speci=
fic
> > configuration fields that can take various values. There is usually some
> > top-level indication of profile/level that restricts what can be used.
> >=20
> > This is a very similar situation to stateful encoding, where codec-spec=
ific
> > controls are used to report and set profile/level and configure these a=
spects.
> > A particularly nice thing about it is that we can reuse these existing =
controls
> > and add new ones in the future for features that are not yet covered.
> >=20
> > This approach feels more flexible than designing new structures with a =
selected
> > set of parameters (that could match the existing controls) for each cod=
ec.
>=20
> Though, reading more into this emails, we still have a fair amount of con=
trols
> to design and add, probably some compound controls too ?

Yeah definitely. My point here is merely that we should reuse existing cont=
rol
for general codec features, but I don't think we'll get around introducing =
new
ones for stateless-specific parts.

> >=20
> > # Reference and Reconstruction Management
> >=20
> > With stateless encoding, we need to tell the hardware which frames need=
 to be
> > used as references for encoding the current frame and make sure we have=
 the
> > these references available as decoded frames in memory.
> >=20
> > Regardless of references, stateless encoders typically need some memory=
 space to
> > write the decoded (known as reconstructed) frame while it's being encod=
ed.
> >=20
> > One question here is how many slots for decoded pictures should be allo=
cated
> > by the driver when starting to stream. There is usually a maximum numbe=
r of
> > reference frames that can be used at a time, although perhaps there is =
a use
> > case to keeping more around and alternative between them for future ref=
erences.
> >=20
> > Another question is how the driver should keep track of which frame wil=
l be used
> > as a reference in the future and which one can be evicted from the pool=
 of
> > decoded pictures if it's not going to be used anymore.
> >=20
> > A restrictive approach would be to let the driver alone manage that, si=
milarly
> > to how stateful encoders behave. However it might provide extra flexibi=
lity
> > (and memory gain) to allow userspace to configure the maximum number of=
 possible
> > reference frames. In that case it becomes necessary to indicate if a gi=
ven
> > frame will be used as a reference in the future (maybe using a buffer f=
lag)
> > and to indicate which previous reference frames (probably to be identif=
ied with
> > the matching output buffer's timestamp) should be used for the current =
encode.
> > This could be done with a new dedicated control (as a variable-sized ar=
ray of
> > timestamps). Note that userspace would have to update it for every fram=
e or the
> > reference frames will remain the same for future encodes.
> >=20
> > The driver will then make sure to keep the reconstructed buffer around,=
 in one
> > of the slots. When there's no slot left, the driver will drop the oldest
> > reference it has (maybe with a bounce buffer to still allow it to be us=
ed as a
> > reference for the current encode).
> >=20
> > With this behavior defined in the uAPI spec, userspace will also be abl=
e to
> > keep track of which previous frame is no longer allowed as a reference.
>=20
> If we want, we could mirror the stateless decoders here. During the decod=
ing, we
> pass a "dpb" or a reference list, which represent all the active referenc=
es.
> These do not have to be used by the current frame, but the driver is allo=
wed to
> use this list to cleanup and free unused memory (or reuse in case it has =
a fixed
> slot model, like mtk vcodec).
>=20
> On top of this, we add a list of references to be used for producing the =
current
> frame. Usually, the picture references are indices into the dpb/reference=
 list
> of timestamp. This makes validation easier.  We'll have to define how many
> reference can be used I think since unlike decoders, encoders don't have =
to
> fully implement levels and profiles.

So that would be a very explicit description instead of expecting drivers to
do the maintainance and userspace to figure out which frame was evicted from
the list. So yeah this feels more robust!

Regarding the number of reference frames, I think we need to specify both
how many references can be used at a time (number of hardware slots) and how
many total references can be in the reference list (number of rec buffers to
keep around).

We could also decide that making the current frame part of the global refer=
ence
list is a way to indicate that its reconstruction buffer must be kept aroun=
d,
or we could have a separate way to indicate that. I lean towards the former
since it would put all reference-related things in one place and avoid comi=
ng
up with a new buffer flag or such.

Also we would probably still need to do some validation driver-side to make
sure that userspace doesn't put references in the list that were not marked
as such when encoded (and for which the reconstruction buffer may have been
recycled already).

> >=20
> > # Frame Types
> >=20
> > Stateless encoder drivers will typically instruct the hardware to encod=
e either
> > an intra-coded or an inter-coded frame. While a stream composed only of=
 a single
> > intra-coded frame followed by only inter-coded frames is possible, it's
> > generally not desirable as it is not very robust against data loss and =
makes
> > seeking difficult.
>=20
> Let's avoid this generalization in our document and design. In RTP stream=
ing,
> like WebRTP or SIP, it is desirable to use open GOP (with nothing else th=
en P
> frames all the time, except the very first one). The FORCE_KEY_FRAME is m=
eant to
> allow handling RTP PLI (and other similar feedback). Its quite rare an
> application would mix close GOP and FORCE_KEY_FRAME, but its allowed thou=
gh.
> What I've seen the most, is the FORCE_KEY_FRAME would just start a new GO=
P,
> following size and period from this new point.

Okay fair enough, thanks for the details!

> >=20
> > As a result, the frame type is usually decided based on a given GOP size
> > (the frequency at which a new intra-coded frame is produced) while intr=
a-coded
> > frames can be explicitly requested upon request. Stateful encoders impl=
ement
> > these through dedicated controls:
> > - V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME
> > - V4L2_CID_MPEG_VIDEO_GOP_SIZE
> > - V4L2_CID_MPEG_VIDEO_H264_I_PERIOD
> >=20
> > It seems that reusing them would be possible, which would let the drive=
r decide
> > of the particular frame type.
> >=20
> > However it makes the reference frame management a bit trickier since re=
ference
> > frames might be requested from userspace for a frame that ends up being
> > intra-coded. We can either allow this and silently ignore the info or e=
xpect
> > that userspace keeps track of the GOP index and not send references on =
the first
> > frame.
> >=20
> > In some codecs, there's also a notion of barrier key-frames (IDR frames=
 in
> > H.264) that strictly forbid using any past reference beyond the frame.
> > There seems to be an assumption that the GOP start uses this kind of fr=
ame
> > (and not any intra-coded frame), while the force key frame control does=
 not
> > particularly specify it.
> >=20
> > In that case we should flush the list of references and userspace shoul=
d no
> > longer provide references to them for future frames. This puts a requir=
ement on
> > userspace to keep track of GOP start in order to know when to flush its
> > reference list. It could also check if V4L2_BUF_FLAG_KEYFRAME is set, b=
ut this
> > could also indicate a general intra-coded frame that is not a barrier.
> >=20
> > So another possibility would be for userspace to explicitly indicate wh=
ich
> > frame type to use (in a codec-specific way) and act accordingly, leavin=
g any
> > notion of GOP up to userspace. I feel like this might be the easiest ap=
proach
> > while giving an extra degree of control to userspace.
>=20
> I also lean toward this approach ...
>=20
> >=20
> > # Rate Control
> >=20
> > Another important feature of encoders is the ability to control the amo=
unt of
> > data produced following different rate control strategies. Stateful enc=
oders
> > typically do this in-firmware and expose controls for selecting the str=
ategy
> > and associated targets.
> >=20
> > It seems desirable to support both automatic and manual rate-control to
> > userspace.
> >=20
> > Automatic control would be implemented kernel-side (with algos possibly=
 shared
> > across drivers) and reuse existing stateful controls. The advantage is
> > simplicity (userspace does not need to carry its own rate-control
> > implementation) and to ensure that there is a built-in mechanism for co=
mmon
> > strategies available for every driver (no mandatory dependency on a pro=
prietary
> > userspace stack). There may also be extra statistics or controls availa=
ble to
> > the driver that allow finer-grain control.
>=20
> Though not controlling the GOP (or no gop) might require a bit more work =
on
> driver side. Today, we do have queues of request, queues of buffer etc. B=
ut it
> is still quite difficult to do lookahead these queues. That is only usefu=
l if
> rate control algorithm can use future frame type (like keyframe) to make
> decisions. That could be me pushing to far here though.

Yes I agree the interaction between userspace GOP control and kernel-side
rate-contrly might be quite tricky without any indication of what the next =
frame
types will be.

Maybe we could only allow explicit frame type configuration when using manu=
al
rate-control and have kernel-side GOP management when in-kernel rc is used
(and we can allow it with manual rate-control too). I like having this opti=
on
because it allows for simple userspace implementations.

Note that this could perhaps also be added as an optional feature
for stateful encoders since some of them seem to be able to instruct the
firmware what frame type to use (in addition to directly controlling QP).
There's also a good chance that this feature is not available when using
a firmware-backed rc algorithm.

> >=20
> > Manual control allows userspace to get creative and requires the abilit=
y to set
> > the quantization parameter (QP) directly for each frame (controls are a=
lready
> > as many stateful encoders also support it).
> >=20
> > # Regions of Interest
> >=20
> > Regions of interest (ROIs) allow specifying sub-regions of the frame th=
at should
> > be prioritized for quality. Stateless encoders typically support a limi=
ted
> > number and allow setting specific QP values for these regions.
> >=20
> > While the QP value should be used directly in manual rate-control, we p=
robably
> > want to have some "level of importance" setting for kernel-side rate-co=
ntrol,
> > along with the dimensions/position of each ROI. This could be expressed=
 with
> > a new structure containing all these elements and presented as a variab=
le-sized
> > array control with as many elements as the hardware can support.
>=20
> Do you see any difference in ROI for stateful and stateless ? This looks =
like a
> feature we could combined. Also, ROI exist for cameras too, I'd probably =
try and
> keep them separate though.

I feel like the stateful/stateless behavior should be the same, so that cou=
ld be
a shared control too. Also we could use a QP delta which would apply to both
manual and in-kernel rate-control, but maybe that's too low-level in the la=
tter
case (not very obvious when a relevant delta could be when userspace has no=
 idea
of the current frame-wide QP value).

> This is a very good overview of the hard work ahead of us. Looking forwar=
d on
> this journey and your Allwinner driver.

Thanks a lot for your input!

Honestly I was expecting that it would be more difficult than decoding, but=
 it
turns out it might not be the case.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--u6AcEc8pxRb1aObE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmSus4wACgkQ3cLmz3+f
v9FFfQf/Zoy5Edxhh3RA3yW1I0sA9fXdqSzDX+1+cIGsuZUUML2uNtUT9XjxmUuT
bfl6uvfL71P34+gAZQg3DSEFw3fw7GFRhZinmluDc6biJA8fD2YR54qcRfIi7e6C
PJ8XNxsbKHR2b4gjygFG55wkTBO/qCty/Qd0nrLa83SK0J++JxxsMAxP0Zg9cMZt
pBOsCTQT0EHstoHjjrjCtgYz6EtIeMqhuOE0f66BxQzbTeQpPXFimUV5PwGZMpAc
J25QaTWj6Rc0A65ZqJ9XxfdmFJCwxJGGzLv4jvfW7gttJQaNr+ogRpwPQQ0yestb
awfv+/Yz9GCXNRRzzJqEi9M1gKwDbQ==
=mdMo
-----END PGP SIGNATURE-----

--u6AcEc8pxRb1aObE--
