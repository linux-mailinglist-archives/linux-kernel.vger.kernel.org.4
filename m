Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D3269423A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjBMKFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBMKFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:05:51 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0CB762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:05:45 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:5d34:d0af:a884:130e])
        by michel.telenet-ops.be with bizsmtp
        id La5i290073vMoCy06a5i3d; Mon, 13 Feb 2023 11:05:42 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pRVi6-008u06-FO
        for linux-kernel@vger.kernel.org;
        Mon, 13 Feb 2023 11:05:42 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pRViQ-001NO0-6g
        for linux-kernel@vger.kernel.org;
        Mon, 13 Feb 2023 11:05:42 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.2-rc8
Date:   Mon, 13 Feb 2023 11:05:42 +0100
Message-Id: <20230213100542.328169-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wj1=T1KzpPWbhqfFWOEp5Wf_kj3JjTHSHmEngf0-Vv7aA@mail.gmail.com>
References: <CAHk-=wj1=T1KzpPWbhqfFWOEp5Wf_kj3JjTHSHmEngf0-Vv7aA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v6.2-rc8[1] compared to v6.1[2].

Summarized:
  - build errors: +20/-14
  - build warnings: +30/-10

JFYI, when comparing v6.2-rc8[1] to v6.2-rc7[3], the summaries are:
  - build errors: +11/-1
  - build warnings: +0/-0

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ceaa837f96adb69c0=
df0397937cd74991d5d821a/ (all 152 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/830b3c68c1fb1e917=
6028d02ef86f3cf76aa2476/ (all 152 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4ec5183ec48656cec=
489c49f989c508b68b518e3/ (all 152 configs)


*** ERRORS ***

20 error regressions:
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_=
mode_vba_31.c: error: the frame size of 2224 bytes is larger than 2048 byte=
s [-Werror=3Dframe-larger-than=3D]:  =3D> 7082:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display=
_mode_vba_314.c: error: the frame size of 2208 bytes is larger than 2048 by=
tes [-Werror=3Dframe-larger-than=3D]:  =3D> 7127:1
  + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: arra=
y subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-W=
error=3Darray-bounds]:  =3D> 641:28
  + /kisskb/src/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c: error: arra=
y subscript 3 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-W=
error=3Darray-bounds]:  =3D> 641:28
  + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gc=
c/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: 'gimp=
le_call_addr_fndecl' was not declared in this scope:  =3D> 2790:10
  + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gc=
c/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: 'is_g=
imple_reg' was not declared in this scope:  =3D> 2556:18
  + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gc=
c/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field=
 'call_clobbered' has incomplete type 'pt_solution':  =3D> 284:22
  + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gc=
c/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field=
 'call_used' has incomplete type 'pt_solution':  =3D> 283:22
  + {standard input}: Error: unknown pseudo-op: `.cfi_def_c':  =3D> 1718
  + {standard input}: Error: unrecognized opcode: `dcbfl':  =3D> 4464, 5224=
, 4602, 5067, 5079, 4327, 5195, 5212, 5050, 4476, 4298, 5594, 5736, 4743, 4=
447, 4315
  + {standard input}: Error: unrecognized opcode: `dlmzb.':  =3D> 2842, 112=
, 2383, 2848, 3327, 2377, 18800, 106
  + {standard input}: Error: unrecognized opcode: `iccci':  =3D> 510, 204, =
163
  + {standard input}: Error: unrecognized opcode: `lbarx':  =3D> 570, 196
  + {standard input}: Error: unrecognized opcode: `mbar':  =3D> 703, 7523, =
662, 1125, 558, 1385, 1172, 837, 887, 1410, 1100, 441, 368, 539, 815, 516, =
468, 1457
  + {standard input}: Error: unrecognized opcode: `mfdcr':  =3D> 3589, 128,=
 3493, 4413, 3469, 3614, 4358, 276, 3445, 3518, 3565, 3541
  + {standard input}: Error: unrecognized opcode: `mtdcr':  =3D> 4430, 4402=
, 4375, 4388, 265, 4443, 117, 4347
  + {standard input}: Error: unrecognized opcode: `stbcx.':  =3D> 570, 196
  + {standard input}: Error: unrecognized opcode: `tlbwe':  =3D> 477, 476, =
475
  + {standard input}: Error: unrecognized opcode: `wrtee':  =3D> 2905, 4570=
, 75569, 6113, 40539, 20201, 3344, 3364, 75087, 4558, 5693, 7764, 3025, 779=
5, 1119, 3153, 1145, 41278, 11065, 2879, 17833, 303, 23301, 35913, 9886, 59=
80, 4772, 2263, 1424, 23765, 4533, 18569, 892, 20957, 1348, 12480, 16655, 6=
91, 22966, 14148, 21407, 13141, 23455, 7721, 1858, 12092, 3091, 6260, 6240,=
 45926, 5702, 1514, 1882, 18423, 10688, 4228, 5004, 10881, 36535, 20248, 19=
164, 18919, 26423, 3032, 12601, 4855, 6722, 2980, 4107, 21741, 12725, 4677,=
 20227, 706, 7088, 46496, 23048, 19561, 10924, 42121, 2026, 15428, 15168, 1=
4592, 9050, 32220, 12992, 1757, 10263, 20322, 394, 9483, 2527, 10800, 4581,=
 17902, 26743, 21787, 1526, 5842, 12709, 8019, 6677, 1479, 24275, 2351, 356=
7, 3290, 10716, 5607, 5173, 24926, 7250, 6983, 2791, 19682, 3075, 13513, 18=
644, 15260, 1584, 6175, 6532, 13762, 27466, 23902, 14902, 15443, 3161, 1855=
2, 10181, 2631, 39419, 7008, 13139, 21571, 13734, 41055, 12008, 32665, 1339=
2, 5505, 4889, 1762, 5646, 46047, 5412, 2236, 9607, 1698, 6459, 1297, 7671,=
 11643, 23394, 13805, 180, 3434, 58764, 10242, 2164, 18976, 2797, 24545, 74=
21, 7672, 19534, 24030, 1178, 1220, 30016, 25557, 4591, 6933, 38343, 31636,=
 419, 17145, 19789, 53740, 33649, 21838, 37777, 442, 5296, 4204, 14377, 539=
60, 1976, 25100, 549, 12920, 7495, 4480, 512, 852, 43737, 4556, 23272, 1463=
, 5521, 22483, 32397, 3017, 713, 24673, 25730, 10267, 1346, 10824, 5216, 14=
141, 20496, 6409, 1607, 5451, 7957, 9128, 10112, 8333, 2073, 11485, 6174, 2=
565, 26536, 30895, 50699, 2534, 57740, 1959, 8027, 2641, 58308, 2441, 931, =
9302, 2292, 74840, 14387, 715, 1701, 25681, 17627, 18558, 3098, 7789, 13642=
, 35829, 1185, 12272, 14282, 1577, 23883, 26630, 68914, 9866, 38831, 1766, =
2688, 28005, 11059, 5642, 7215, 311, 45373, 20540, 9463, 12037, 13052, 6373=
, 10400, 22104, 2555, 654, 2674, 42584, 25462, 727, 11938, 9022, 2984, 7040=
2, 6986, 2989, 40354, 310, 1944, 30060, 3276, 5708, 28187, 11716, 36739, 45=
4, 27620, 3454, 4373, 6908, 3187, 4750, 38090, 708, 3785, 19239, 30937, 133=
6, 564, 7385, 10674, 6619, 7414, 4967, 1697, 2027, 6499, 26086, 27144, 1725=
, 12852, 34081, 8817, 1670, 15378, 2155, 30860, 40030, 23401, 7745, 5463, 1=
4383, 41221, 6092, 4678, 1089, 19754, 27530, 19978, 12127, 1144, 10049, 158=
14, 28680, 11009, 41177, 3987, 12052, 17326, 18002, 23709, 4322, 13246, 127=
4, 1843, 14158, 796, 9266, 58142, 14445, 14841, 4359, 2021, 21538, 41505, 4=
354, 20981, 8447, 13764, 5178, 19263, 19862, 8663, 14734, 4031, 1977, 24177=
, 18913, 1601, 5325, 3764, 15100, 1171, 6138, 29773, 3902, 2729, 44812, 118=
50, 5233, 18886, 1687, 703, 9674, 2059, 8955, 2312, 8909, 207, 16070, 9696,=
 5955, 26249, 399, 39533, 13529, 5832, 34975, 20431, 12604, 5812, 19059, 29=
99, 4344, 6091, 10478, 17949, 12018, 9878, 25320, 473, 1529, 2855, 786, 124=
31, 1310, 22831, 11027, 53821, 692, 1081, 10694, 1908, 18359, 1614, 5193, 8=
91, 2334, 17713, 10494, 7693, 6413, 18716, 3095, 15117, 3618, 20492, 13205,=
 5715, 773, 20301, 3909, 9917, 19610, 10870, 3213, 13138, 18411, 2894, 4449=
4, 14057, 15837, 37195, 8314, 8029, 6341, 4648, 34889, 4247, 9234, 3939, 52=
50, 11268, 10513, 7585, 1562, 4712, 1551, 81724, 20823, 7712, 14012, 19969,=
 30334, 5485, 6014, 19732, 19845, 3383, 10594, 9948, 5685, 45806, 374, 1327=
, 2289, 6286, 31390, 1097, 1655, 17682, 26924, 23662, 2749, 71726, 26672, 9=
587, 11045, 35831, 9889, 21816, 757, 3629, 31789, 25774, 5187, 18015, 31562=
, 19555, 2435, 9966, 4206, 37290, 13025, 1153, 14524, 2255, 13230, 3452, 26=
292, 17409, 23443, 13906, 2556, 9754, 12507, 3661, 10979, 18267, 4401, 1044=
5, 5710, 1942, 23777, 19098, 4687, 46633, 37966, 1002, 4612, 740, 1091, 997=
5, 3090, 5884, 45665, 457, 10829, 10904, 320, 9722, 5512, 8112, 6818, 251, =
11619, 999, 542, 663, 5495, 25810, 32580, 27710, 712, 11788, 4040, 7135, 11=
240, 1167, 1359, 5635, 761, 13875, 5997, 26928, 1277, 1678, 12446, 14999, 2=
7050, 4782, 5102, 12599, 4135, 553, 19430, 21548, 6900, 40953, 4169, 8695, =
16461, 8226, 8664, 19797, 1052, 6337, 5244, 6442, 21152, 13357, 20026, 3144=
, 2271, 19747, 13574, 14061, 25658, 9518, 33687, 4848, 46636, 19042, 61864,=
 15141, 216, 17850, 24184, 2645, 28499, 1394, 20577, 1345, 6820, 13447, 343=
42, 10257, 2254, 6231, 23024, 10203, 14496, 51189, 5957, 11129, 19781, 1405=
0, 8551, 17465, 3491, 24500, 11724, 5953, 1673, 5516, 10404, 11451, 1630, 2=
3719, 12349, 38123, 8579, 2141, 6291, 18634, 12744, 4397, 3564, 12353, 5188=
, 41896, 55439, 40599, 4594, 7576, 324, 5499, 44986, 21373, 2235, 6292, 738=
, 6201, 40156, 35671, 8986, 14950, 27443, 21973, 2455, 2327, 17283, 22918, =
59753, 6194, 16862, 2784, 9895, 3492, 4817, 32658, 13400, 39897, 6708, 1570=
, 9359, 20087, 620, 191, 7870, 7307, 4085, 1925, 1051, 34489, 3554, 21001, =
16961, 20016, 4287, 466, 4199, 4283, 2953, 4165, 27185, 14335, 3720, 7303, =
11054, 1480, 916, 7761, 21151, 2460, 18650, 19544, 30912, 3842, 9465, 7207,=
 22825, 36469, 4332, 18751, 24307, 5895, 23034, 8147, 37936, 14204, 3045, 1=
0408, 3573, 45046, 15448, 2118, 1635, 15904, 18831, 7268, 11601, 837, 20854=
, 2364, 26524, 2025, 2684, 9800, 7976, 45223, 6686, 6059, 35314, 2153, 5092=
, 894, 5821, 17014, 10563, 35791, 7926, 15262, 1276, 9300, 2450, 20083, 198=
42, 52043, 43983, 37762, 296, 5916, 10166, 26121, 1471, 1214, 5349, 17038, =
1219, 18307, 14974, 1101, 9151, 3697, 4774, 27068, 3458, 21377, 37183, 9885=
, 19413, 8518, 2765, 14962, 3218, 25711, 12606, 13990, 1840, 18559, 10880, =
5315, 10290, 15706, 2880
  + {standard input}: Error: unrecognized opcode: `wrteei':  =3D> 3418, 968=
0, 20430, 1506, 23789, 15348, 24205, 6100, 36608, 24287, 11430, 11301, 2129=
3, 492, 4944, 22990, 12557, 14447, 635, 18507, 22046, 23811, 3796, 3184, 75=
043, 7257, 3453, 27422, 37703, 11731, 24216, 2314, 7972, 30893, 4523, 9672,=
 9970, 26393, 3049, 21694, 671, 4829, 30997, 8240, 486, 17190, 18961, 572, =
484, 45621, 61825, 30814, 1161, 11195, 4470, 34037, 591, 8289, 39434, 20145=
, 19002, 18219, 1967, 13688, 7935, 8902, 16903, 23846, 30612, 39506, 13914,=
 13696, 19520, 26485, 20117, 12665, 473, 6824, 21141, 277, 43823, 11317, 39=
26, 10469, 16112, 34848, 13599, 14003, 26640, 1295, 21637, 590, 1426, 2902,=
 38281, 11542, 2193, 6648, 668, 45061, 2158, 18050, 2744, 1784, 18914, 1093=
, 2600, 19169, 21677, 2749, 22643, 27915, 22353, 9501, 3054, 11017, 5168, 7=
648, 8477, 768, 24124, 24464, 14864, 697, 13791, 42711, 1017, 4208, 436, 12=
981, 25423, 26210, 7190, 6341, 3856, 14971, 3706, 28534, 4094, 14625, 23971=
, 24159, 2814, 18710, 2834, 6585, 2240, 14400, 10793, 3994, 5410, 11866, 66=
20, 5181, 14368, 1918, 13361, 5987, 37027, 13585, 13546, 70248, 12565, 1307=
4, 6241, 16578, 10841, 4666, 4224, 1822, 5512, 17365, 11288, 21774, 11951, =
2102, 70, 11246, 12499, 20037, 15253, 1011, 7985, 4252, 19333, 33613, 21979=
, 6386, 624, 25304, 3114, 70340, 18859, 2495, 6412, 1369, 6768, 19001, 1070=
0, 958, 27432, 6363, 24843, 25281, 9983, 4707, 7159, 8566, 92, 19636, 18128=
, 46706, 10183, 22864, 5654, 14244, 3767, 35245, 39149, 5265, 7224, 1230, 2=
3199, 28111, 5340, 14831, 36265, 6172, 4144, 7611, 14461, 4028, 9062, 30507=
, 13861, 26878, 12314, 31165, 7491, 10747, 15323, 59714, 2378, 4236, 12599,=
 9600, 1547, 38908, 1844, 18028, 4737, 17896, 16053, 3382, 11880, 14007, 20=
43, 323, 22606, 6169, 2166, 6398, 2183, 2086, 1961, 25083, 24850, 31748, 10=
87, 16650, 13267, 1066, 29214, 45882, 39812, 5469, 2214, 14190, 23332, 3067=
2, 38191, 999, 10167, 13934, 3803, 859, 35752, 13362, 7144, 37799, 14223, 7=
0682, 2903, 15920, 3180, 14229, 2330, 3279, 8784, 57946, 2943, 2963, 29463,=
 8728, 17512, 11804, 23688, 10948, 901, 12461, 37502, 1912, 5760, 1966, 721=
1, 2081, 11019, 3515, 1992, 11469, 10117, 22770, 10033, 7451, 9428, 9153, 1=
5308, 6479, 9484, 10398, 20129, 18280, 4313, 22900, 9805, 1507, 16572, 8562=
, 6126, 2129, 3262, 19136, 11108, 645, 13065, 5235, 3521, 39705, 6820, 1088=
, 13697, 2385, 23411, 13957, 24184, 4479, 5269, 3758, 34930, 19228, 9321, 7=
29, 12088, 621, 4211, 12340, 68804, 4679, 9091, 5789, 30021, 7126, 23393, 1=
4343, 1581, 14716, 53696, 9371, 16720, 5007, 7077, 8499, 5827, 5106, 16938,=
 19930, 27146, 360, 6519, 6708, 18184, 4950, 7882, 33610, 2280, 14338, 1669=
9, 25127, 14449, 2938, 7661, 64995, 9285, 193, 8634, 23596, 16378, 5947, 15=
437, 21436, 1096, 6629, 28407, 19774, 5222, 12911, 26003, 6232, 2327, 2655,=
 5634, 10703, 34004, 3973, 2249, 5439, 2097, 2196, 14553, 4534, 2728, 55395=
, 18286, 10583, 75525, 15275, 3252, 10173, 8373, 3224, 326, 28881, 3487, 24=
434, 2162, 8390, 46576, 50660, 37660, 3154, 23791, 1911, 6652, 4893, 7287, =
35047, 3159, 9929, 29151, 3343, 6268, 35881, 2484, 31078, 6686, 32619, 1665=
7, 2689, 81529, 1850, 1464, 19261, 18659, 2344, 15979, 6054, 11930, 1700, 5=
906, 1255, 287, 18556, 41871, 2755, 25285, 5739, 17791, 14106, 20808, 368, =
8844, 32746, 25691, 4375, 14684, 8678, 1415, 74796, 10616, 17219, 29676, 52=
85, 24064, 24196, 1472, 15192, 12425, 2518, 19119, 5586, 2822, 21510, 151, =
37042, 5273, 5108, 8508, 1680, 1360, 18085, 17421, 2854, 916, 21845, 2557, =
5924, 1209, 2916, 6408, 38333, 13456, 6939, 37376, 6914, 10246, 10351, 1320=
2, 19929, 23962, 3342, 11480, 22653, 12562, 20262, 21746, 26007, 1785, 3417=
, 6297, 371, 17653, 40074, 4955, 6069, 2066, 16824, 13940, 1245, 1265, 3132=
4, 22818, 5489, 35787, 14758, 12615, 6035, 6418, 34437, 12357, 5951, 27534,=
 13088, 10516, 3670, 8916, 14109, 3493, 14081, 10788, 7540, 5056, 9953, 956=
2, 28568, 3100, 2739, 8440, 15517, 6742, 780, 2210, 19905, 4189, 6751, 2730=
3, 5460, 2835, 23671, 832, 41682, 2924, 4356, 9810, 35632, 14878, 809, 1446=
8, 14928, 7021, 1605, 4438, 20797, 1008, 2952, 19916, 1276, 24514, 2678, 22=
521, 4035, 12295, 4638, 2075, 2844, 1587, 17050, 4716, 17646, 2450, 2849, 3=
351, 2290, 14900, 39270, 4600, 19096, 8921, 9242, 44056, 36907, 26858, 2837=
3, 941, 1461, 3709, 23345, 14851, 16395, 14398, 949, 9456, 6593, 1275, 9398=
, 11807, 9149, 8433, 12092, 71551, 23073, 25532, 3996, 19713, 30139, 14301,=
 1786, 27209, 4582, 51150, 573, 19831, 9549, 8852, 16952, 15780, 1145, 5413=
, 6749, 248, 35817, 19678, 7042, 9863, 15773, 5218, 42578, 11562, 2668, 236=
70, 37890, 35790, 5055, 3200, 42032, 42202, 24026, 11357, 7749, 2792, 22419=
, 22923, 6182, 3273, 3450, 4088, 5407, 19766, 8388, 38776, 404, 18523, 848,=
 10978, 45329, 37733, 7677, 17951, 17510, 57545, 300, 5585, 18916, 3277, 22=
313, 6473, 11628, 24743, 2731, 957, 11899, 16539, 1479, 12495, 4052, 14676,=
 924, 14757, 9646, 35626, 1397, 129, 2055, 940, 24867, 5352, 37415, 235, 11=
597, 25178, 64806, 32216, 6809, 16823, 9838, 15084, 3032, 123, 568, 25335, =
102, 12867, 11099, 10997, 15559, 139, 1356, 17837, 249, 20260, 12963, 3414,=
 2144, 3619, 985, 6187, 9896, 4566, 5343, 3499, 17048, 4512, 34618, 41070, =
5748, 23994, 37164, 4276, 241, 27363, 2318, 25204, 7183, 3129, 1418, 7047, =
2251, 1021, 12551, 20988, 2121, 5050, 4112, 5707, 6501, 4187, 517, 1892, 18=
680, 8973, 34303, 4903, 610, 25997, 26979, 6889, 8990, 1584, 14037, 13955, =
2631, 17052, 647, 2863, 8601, 1140, 11737, 257, 18686, 12830, 1383, 12759, =
1724, 16505, 23123, 984, 26633, 20364, 2288, 15949, 19481, 20046, 3136, 666=
9, 2466, 1387, 1550, 27243, 1667, 20940, 3142, 42165, 3116, 10374, 16520, 3=
784, 2252, 5425, 1022, 7649, 7098, 13167, 5656, 15121, 3327, 9791, 719, 262=
34, 23337, 2990, 15321, 4525, 7511, 17768, 3655, 5808, 32181, 5569, 8169, 1=
5390, 419, 2838, 4125, 31579, 24225, 4449, 4644, 11149, 45762, 9437, 5863, =
8656, 19497, 2703, 45179, 12602, 11053, 10125, 12839, 4038, 2675, 14060, 91=
00, 18983, 2105, 23753, 8782, 189, 17148, 5121, 36425, 1203, 17945, 22479, =
5515, 20453, 17433, 1766, 26483, 2194, 24642, 12272, 6323, 25245, 26692, 13=
4, 1648, 6873, 1247, 2232, 23320, 11572, 12290, 7810, 6058, 7082, 5753, 726=
4, 5225, 5820, 6830, 11343, 1510, 5126, 5000, 3057, 25298, 5757, 3098, 1974=
2, 2950, 3226, 9716, 9742, 15061, 2030, 30732, 53782, 4784, 15078, 2010, 13=
404, 2882, 11229, 4426, 31495, 7409, 4295, 6221, 24145, 46003, 2381, 1110, =
40867, 38046, 2307, 14214, 17200, 2893, 4810, 14839, 5451, 353, 14141, 1771=
8, 1177, 16879, 1896, 3472, 18980, 4136, 2753, 15138, 53916, 23224, 28129, =
2696, 2397, 27405, 16677, 18455, 13837, 5950, 2155, 52004, 1127, 14319, 122=
53, 13530, 2000, 7561, 8837, 14119, 5786, 6561, 2313, 456, 1413, 14623, 261=
6, 564, 14544, 70120, 2436, 24133, 20124, 23054, 3889, 846, 4499, 23551, 78=
23, 15150, 8786, 24231, 5303, 3008, 40735, 6552, 19736, 27491, 27151, 10289=
, 15632, 2868, 4561, 10400, 1824, 976, 2109, 21368, 4222, 4434, 24265, 1863=
0, 18483, 1500, 44574, 17304, 16502, 10821, 2926, 2391, 16958, 17513, 24817=
, 11034, 3826, 14617, 3677, 7895, 37835, 3901, 46582, 64638, 5825, 58247, 2=
1090, 1549, 18232, 3987, 2812, 3061, 37838, 27555, 58725, 9212, 4001, 5999,=
 9368, 10575, 14939, 6678, 15292, 637, 4906, 12476, 2049, 6012, 2540, 2044,=
 1656, 1089, 13563, 883, 20283, 24749, 42719, 24405, 1717, 16192, 16601, 17=
82, 45002, 1135, 14401, 9514, 7508, 31108, 19082, 11147, 9381, 13944, 3168,=
 70967, 231, 4478, 1338, 528, 7598, 25340, 8293, 4200, 11668, 391, 923, 131=
66, 16225, 16810, 12345, 13044, 20878, 23545, 1206, 16070, 11006, 9256, 117=
30, 23718, 403, 14595, 23228, 12869, 15755, 21921, 1050, 27945, 18960, 4138=
, 33971, 14689, 5892, 3533, 6640, 25675, 1910, 17460, 15665, 21046, 1483, 2=
663, 14262, 23633, 3137, 19241, 228, 1229, 12567, 2686, 3715, 632, 1367, 14=
039, 18313, 16781, 3744, 7227, 11362, 7344, 2392, 14274, 601, 4031, 3600, 1=
977, 17908, 21332

14 error improvements:
  - /kisskb/src/arch/sh/include/asm/io.h: error: cast to pointer from integ=
er of different size [-Werror=3Dint-to-pointer-cast]: 239:34 =3D>=20
  - /kisskb/src/arch/sparc/kernel/irq_32.c: error: array subscript [16, 79]=
 is outside array bounds of 'struct tt_entry[1]' [-Werror=3Darray-bounds]: =
258:14, 259:14, 261:46, 262:14, 263:14 =3D>=20
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'X86_VEND=
OR_AMD' undeclared (first use in this function): 149:37 =3D>=20
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'struct c=
puinfo_um' has no member named 'x86_vendor': 149:22 =3D>=20
  - /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: control r=
eaches end of non-void function [-Werror=3Dreturn-type]: 150:1 =3D>=20
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_u=
m' has no member named 'x86_cache_size': 88:22 =3D>=20
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches e=
nd of non-void function [-Werror=3Dreturn-type]: 89:1 =3D>=20
  - /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declarat=
ion of function '__copy_user_nocache' [-Werror=3Dimplicit-function-declarat=
ion]: 100:2 =3D>=20
  - /kisskb/src/drivers/net/ethernet/marvell/prestera/prestera_flower.c: er=
ror: 'rule' is used uninitialized [-Werror=3Duninitialized]: 480:34 =3D>=20
  - {standard input}: Error: displacement to undefined symbol .L377 overflo=
ws 12-bit field: 2286 =3D>=20
  - {standard input}: Error: displacement to undefined symbol .L378 overflo=
ws 8-bit field : 2302 =3D>=20
  - {standard input}: Error: displacement to undefined symbol .L382 overflo=
ws 8-bit field : 2213 =3D>=20
  - {standard input}: Error: pcrel too far: 2206, 2249, 2221, 2209, 2262, 2=
217, 2259, 2247, 2231, 2293, 2216, 2229, 2204, 2261, 2215, 2232, 2274, 2248=
 =3D>=20
  - {standard input}: Error: unknown pseudo-op: `.l': 2305 =3D>=20


*** WARNINGS ***

30 warning regressions:
  + modpost: WARNING: modpost: "__ashldi3" [drivers/block/drbd/drbd.ko] has=
 no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/bus/mhi/host/mhi_pci_ge=
neric.ko] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/extcon/extcon-fsa9480.k=
o] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/md/dm-zoned.ko] has no =
CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/media/cec/core/cec.ko] =
has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/media/usb/hdpvr/hdpvr.k=
o] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/misc/habanalabs/habanal=
abs.ko] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/mtd/nand/onenand/onenan=
d.ko] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nand.ko] h=
as no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/m=
lx5/core/mlx5_core.ko] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/net/wireless/ath/wil621=
0/wil6210.ko] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-sifive.ko] has =
no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ashldi3" [drivers/scsi/hptiop.ko] has no =
CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/block/drbd/drbd.ko] has=
 no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nand.ko] h=
as no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/scsi/sd_mod.ko] has no =
CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__ndelay" [drivers/gpio/gpio-latch.ko] has =
no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/iio/adc/max11410.ko] has=
 no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/input/keyboard/tegra-kbc=
.ko] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/mfd/axp20x.ko] has no CR=
C!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/mmc/host/sunplus-mmc.ko]=
 has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/renesas/rsw=
itch_drv.ko] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-mux-meson-=
g12a.ko] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt=
76/mt7996/mt7996e.ko] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/realtek/rtw=
89/rtw89_8852b.ko] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/phy/renesas/r8a779f0-eth=
er-serdes.ko] has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/ptp/ptp_idt82p33.ko] has=
 no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/usb/fotg210/fotg210.ko] =
has no CRC!:  =3D> N/A
  + modpost: WARNING: modpost: "__udelay" [fs/xfs/xfs.ko] has no CRC!:  =3D=
> N/A
  + modpost: WARNING: modpost: "empty_zero_page" [net/rxrpc/rxperf.ko] has =
no CRC!:  =3D> N/A

10 warning improvements:
  - /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memset'=
 offset [0, 11] is out of the bounds [0, 0] [-Warray-bounds]: 68:25 =3D>=20
  - /kisskb/src/arch/s390/kernel/setup.c: warning: 'memcpy' offset [0, 127]=
 is out of the bounds [0, 0] [-Warray-bounds]: 524:9 =3D>=20
  - /kisskb/src/drivers/net/ethernet/i825xx/sun3_82586.c: warning: array su=
bscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1=
]' [-Warray-bounds]: 989:122, 989:108 =3D> 989:108
  - /kisskb/src/fs/coredump.c: warning: 'dump_emit_page' defined but not us=
ed [-Wunused-function]: 834:12 =3D>=20
  - modpost: WARNING: modpost: "__ashldi3" [lib/zstd/zstd_compress.ko] has =
no CRC!: N/A =3D>=20
  - modpost: WARNING: modpost: "__udelay" [drivers/net/can/pch_can.ko] has =
no CRC!: N/A =3D>=20
  - modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/fealnx.ko] =
has no CRC!: N/A =3D>=20
  - modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/smsc/smc911=
x.ko] has no CRC!: N/A =3D>=20
  - modpost: WARNING: modpost: "__udelay" [drivers/net/pcs/pcs-altera-tse.k=
o] has no CRC!: N/A =3D>=20
  - modpost: WARNING: modpost: "__udelay" [drivers/usb/host/fotg210-hcd.ko]=
 has no CRC!: N/A =3D>=20

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
