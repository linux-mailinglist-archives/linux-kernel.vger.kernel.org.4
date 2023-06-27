Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9617406E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjF0Xij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjF0Xih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:38:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DAE1FE5;
        Tue, 27 Jun 2023 16:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4FDD6121C;
        Tue, 27 Jun 2023 23:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B1FC433C0;
        Tue, 27 Jun 2023 23:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687909113;
        bh=uVAlmvfwTuYJ3dpsZuULPUGZVsxZWZjSUtB0+2wBi4o=;
        h=Date:From:To:Cc:Subject:From;
        b=HAO2hp4fLbDhTniJHnlFJRKh7cBSXEfEDMo1creVW9dA7VKLUpoI1DdpoUR7AFv4G
         rw+yXxxmD2kqncu2y/VrGY6XgS6h6i6CYecYRxkTi40c8sx48VsKszXYMo9lgf7na2
         2ChatiWUe40lP3Dn9iar6C2JU8hk6Cgtl0AmhWwj0TYJCiy1yW0SVr8/iR4KFFDW98
         awnphEu7lR8xFJ4nCD15Mv6MDTIjYYmWYmp2bawnAnU8IMG7ypd2EKyn/2FrYYztTo
         Crh+ToeFoIMPM8jDbcv8Qbsv9GXT9heBi8g06+Po2NvN2kUIXeaxOfLXbm9g4JShDI
         /RnIY333JAciA==
Date:   Tue, 27 Jun 2023 16:38:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     netdev@vger.kernel.org
Cc:     netdev-driver-reviewers@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [ANN] netdev development stats for 6.5
Message-ID: <20230627163832.75f3a340@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have run the fair and impartial statistical analysis (!! :)) script
against the mailing list traffic and git history for the 6.5 release.

6.5 statistics
--------------

The cycle started on April 26th and ended on June 27th, it was the same
length as the previous release cycle.

We have seen total of 15235 messages on the list (246 / day) which is
5% lower than last time (but 9% higher than 6.3). The number of commits
directly applied by netdev maintainers increased slightly but remains
close to 18 commits a day for the 3rd release in a row.

We have seen 778 people/aliases on the list during 6.5 development
which is up 7% from last time. The distribution of the roles these=20
people play remains stable - with 45% who posted patches but never
replied to a thread started by another person, 33% were only replying
and never posting patches, and 20% who did both.

The number of commits which go into the tree with at least one
Review/Ack tag has decreased by 6% and is now at 60% (53% of which do
not come from the same email domain as the author). 6.4 was particularly
good in terms of reviews, and 6.5 is still ~4% better than 6.3 but the
decline is obviously sad to see.

Rankings
--------

Top reviewers (thr):                 Top reviewers (msg):               =20
   1 ( +1) [46] Simon Horman            1 ( +1) [73] Simon Horman       =20
   2 ( -1) [27] Jakub Kicinski          2 ( -1) [50] Jakub Kicinski     =20
   3 (   ) [15] Andrew Lunn             3 (   ) [34] Andrew Lunn        =20
   4 ( +4) [ 9] Paolo Abeni             4 ( +4) [14] Eric Dumazet       =20
   5 ( -1) [ 8] Eric Dumazet            5 ( +5) [14] Russell King       =20
   6 ( +5) [ 7] Russell King            6 (   ) [14] Vladimir Oltean    =20
   7 ( -1) [ 4] Krzysztof Kozlowski     7 ( -2) [13] Krzysztof Kozlowski=20
   8 (***) [ 4] Jiri Pirko              8 (***) [12] Jiri Pirko         =20
   9 (   ) [ 4] Vladimir Oltean         9 ( +5) [12] Paolo Abeni        =20
  10 (+27) [ 4] Maciej Fijalkowski     10 ( +5) [10] Michael S. Tsirkin =20
  11 ( +8) [ 4] David Ahern            11 (+18) [ 7] David Ahern        =20
  12 (+12) [ 4] Stephen Hemminger      12 (+37) [ 7] Maciej Fijalkowski =20

Simon rightfully takes the top reviewer position, with Andrew firmly
holding the #3 spot. Thank you both for all the hard work!
Maciej, David Ahern and Jiri Pirko have also been active reviewing,
and enter the top 12 for 6.5, thank you!


Top authors (thr):                   Top authors (msg):                 =20
   1 (   ) [6] Jakub Kicinski           1 ( +1) [33] David Howells      =20
   2 (   ) [4] Eric Dumazet             2 ( -1) [22] Saeed Mahameed     =20
   3 ( +1) [4] Tony Nguyen              3 ( +4) [18] Tony Nguyen        =20
   4 (+36) [4] David Howells            4 (+29) [18] Russell King       =20
   5 (+23) [4] Russell King             5 ( +1) [16] Jakub Kicinski     =20
   6 (+14) [3] Kuniyuki Iwashima        6 (***) [14] Bartosz Golaszewski=20
   7 (***) [3] Christophe JAILLET       7 (+32) [13] Marc Kleine-Budde  =20
   8 (+29) [2] Stephen Rothwell         8 (***) [11] Maciej Fijalkowski =20
   9 ( -6) [2] Vladimir Oltean          9 ( +7) [ 9] Pablo Neira Ayuso  =20
  10 ( -3) [2] Daniel Golle            10 ( -2) [ 9] Ar=C4=B1n=C3=A7 =C3=9C=
NAL         =20

The top author list continues to change a lot release to release.
Notably David Howells tops the patch posting count, with the large
sendpage effort. Russell King authored various patches improving=20
the infrastructure and common code for embedded drivers (general phylink
improvements, SFP rate selection, C73 auto-neg, mdiodev pcs helpers).
Kuniyuki sent quite a few fixes for IP and core layers of the stack.
I make the list mostly due to YNL work.


Company rankings
----------------

Top reviewers (thr):                 Top reviewers (msg):               =20
   1 ( +1) [46] Corigine                1 ( +1) [73] Corigine           =20
   2 ( -1) [32] Meta                    2 ( -1) [64] Meta               =20
   3 ( +1) [22] RedHat                  3 ( +1) [56] RedHat             =20
   4 ( -1) [19] Intel                   4 ( -1) [41] Intel              =20
   5 ( +2) [15] Andrew Lunn             5 ( +1) [34] Andrew Lunn        =20
   6 ( -1) [15] Google                  6 ( +1) [32] nVidia             =20
   7 ( -1) [14] nVidia                  7 ( -2) [30] Google             =20

Simon's efforts put Corigine at #1 but overall no major movement.
In fact companies at #8 have half of the review volume of #7, so
the top #7 corp reviewers may be the most stable of all rankings
for a long time.


Top authors (thr):                   Top authors (msg):                 =20
   1 ( +1) [16] Intel                   1 ( +2) [79] Intel              =20
   2 ( -1) [16] RedHat                  2 ( -1) [57] RedHat             =20
   3 ( +1) [ 8] nVidia                  3 ( -1) [46] nVidia             =20
   4 ( -1) [ 7] Meta                    4 ( +7) [23] Oracle             =20
   5 (   ) [ 7] Google                  5 ( +1) [21] Meta               =20
   6 ( +4) [ 6] Huawei                  6 (+27) [18] Microchip          =20
   7 (   ) [ 6] AMD                     7 ( +7) [16] Pengutronix        =20

Intel takes #1 for patches sent because of the additional volume=20
of iwl-next patches which now reach netdev. David Howells keeps
Red Hat at #2.


Changes
-------

A sidebar before the last ranking - the company "scores" - because=20
the way scores are calculated has changed. The "score" statistics used
to be very lenient, counting a single review as equal to 3 patches:

score =3D review_threads * 10 + (review_msgs - 1) * 2=20
      - author_threads *  3 - (author_msgs / 2)

The formula now ignores the number of patch sets (threads) but=20
counts authored messages 8 times heavier:

score =3D review_threads * 10 + (review_msgs - 1) * 2
                            - (author_msgs * 4)

There is little science to this. The goal used to be to reprimand
companies which bombard us with patches (mostly stupid automated
"fixes"). That problem has thankfully stopped.

We can now set a more ambitious goal of a fair balance between code
authorship and reviews. We want companies which produce code to still
have a chance making it in the top positive scores, but at the same
time negative scores to include companies which *do* review, just not
enough.

With that out of the way here are the rankings according to the new
formula:

Top balance scores (positive):        Bottom balance scores (negative):    =
         =20
   1 ( +1) [595] Corigine               1 (***) [55] Bartosz Golaszewski=20
   2 ( -1) [359] Meta                   2 (***) [42] Intel              =20
   3 ( +3) [204] Andrew Lunn            3 (***) [40] Bootlin            =20
   4 (   ) [166] Google                 4 (***) [32] Pengutronix        =20
   5 (   ) [101] RedHat                 5 (***) [30] Ar=C4=B1n=C3=A7 =C3=9C=
NAL         =20
   6 ( +2) [ 88] Linaro                 6 ( +9) [29] Trustnetic         =20
   7 ( +9) [ 53] Enfabrica          =20
   8 (+14) [ 38] Microsoft          =20
   9 ( +1) [ 37] NXP                =20
  10 (***) [ 34] Linux Foundation   =20
  11 (+16) [ 33] Mojatatu           =20
  12 ( -1) [ 24] Oracle             =20

On the left side we can easily map to the individuals responsible=20
for their company's position, so I won't cover most.
Greg KH and Linus apparently respond to enough emails to put Linux
Foundation at #10 :)
It's good to see Pedro and Jamal (Mojatatu) make #11.

On the right side we see Bartosz, Bootlin, and Pengutronix, so a lot=20
of Open Source contractors who don't review other people's code,
at least not on netdev.=20
Intel makes the list at #2 because of the large volume of iwl-next
postings which wasn't balanced with a sufficient increase in reviews.
Arinc made one too many quick reposts of his series and makes the list=20
at #5 ;)


Another interesting (to me?) way of looking at this is to see in which
percentile of review balance "score" the top code producers rank:

How top authors rank in scores:
  1  p99 [-42]  Intel
  2   p0 [101]  RedHat
  3   p3 [ 16]  nVidia
  4   p2 [ 23]  Oracle
  5   p0 [358]  Meta
  6  p37 [  0]  Microchip
  7  p99 [-32]  Pengutronix
  8  p98 [-28]  AMD
  9  p99 [-56]  Bartosz Golaszewski
 10  p92 [ -9]  Huawei
 11  p99 [-40]  Bootlin
 12   p4 [ 10]  Broadcom
 13   p0 [165]  Google
 14  p19 [  1]  Isovalent
 15  p96 [-24]  Alibaba

The distribution is rather bi-modal, with most companies either doing
great (<p5) or poorly (>p95). But it is possible to strike a more even
balance (Microchip and Isovalent).

Code: https://github.com/kuba-moo/ml-stat


Thanks to everyone for a productive release cycle! Hopefully we can
all find some time to catch a breath during the merge window and come
back strong for the next one.. and the one after that.. and...
